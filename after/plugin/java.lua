local util = require 'lspconfig.util'
local handlers = require 'vim.lsp.handlers'

local env = {
    HOME = vim.loop.os_homedir(),
    XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
    JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
}

local function get_cache_dir()
    return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or
util.path.join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
    return util.path.join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
    return util.path.join(get_jdtls_cache_dir(), 'config')
end

local function get_jdtls_workspace_dir()
    return vim.fn.stdpath("data") .. "/jdtls/workspaces/" ..
vim.fn.fnamemodify(vim.fs.root(0, {"mvnw", "gradlew"}), ":p:h:t")
    -- return util.path.join(get_jdtls_cache_dir(), 'workspace')
end

local function get_jdtls_jvm_args()
    local args = {}
    for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
        local arg = string.format('--jvm-arg=%s', a)
        table.insert(args, arg)
    end
    return unpack(args)
end

-- TextDocument version is reported as 0, override with nil so that
-- the client doesn't think the document is newer and refuses to update
-- See: https://github.com/eclipse/eclipse.jdt.ls/issues/1695
local function fix_zero_version(workspace_edit)
    if workspace_edit and workspace_edit.documentChanges then
        for _, change in pairs(workspace_edit.documentChanges) do
            local text_document = change.textDocument
            if text_document and text_document.version and
text_document.version == 0 then
                text_document.version = nil
            end
        end
    end
    return workspace_edit
end

local function on_textdocument_codeaction(err, actions, ctx)
    for _, action in ipairs(actions) do
        -- TODO: (steelsojka) Handle more than one edit?
        if action.command == 'java.apply.workspaceEdit' then -- 'action' is
Command in java format
            action.edit = fix_zero_version(action.edit or
action.arguments[1])
        elseif type(action.command) == 'table' and action.command.command
== 'java.apply.workspaceEdit' then -- 'action' is CodeAction in java format
            action.edit = fix_zero_version(action.edit or
action.command.arguments[1])
        end
    end

    handlers[ctx.method](err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
    handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
    handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

-- Non-standard notification that can be used to display progress
local function on_language_status(_, result)
    local command = vim.api.nvim_command
    command 'echohl ModeMsg'
    command(string.format('echo "%s"', result.message))
    command 'echohl None'
end

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end


local function read_classpath()
    local f = io.open(get_jdtls_workspace_dir() ..
"/jdt.ls-java-project/.classpath", "r")
    local lines = {}
    for line in f:lines() do
        table.insert(lines, line .. "\n")
    end

    return lines
end


local function insert_classpath_entry(classpath, path)
    local exists = false
    for key, line in pairs(classpath) do
        if string.find(line, path) then
            exists = true
            return classpath
        end
    end

    if exists == false then
        table.insert(classpath, #classpath, '\t<classpathentry kind="lib"
exported="true" path="' .. path .. '"/>\n')
    end

    return classpath
end


local function update_classpath()
    local handle = io.popen('pwsh -c "$PSStyle.OutputRendering =
[System.Management.Automation.OutputRendering]::PlainText; gradle
getClassPath | Select-String "C:.*?jar""')
    ---@diagnostic disable-next-line: need-check-nil
    local result = handle:read("*a")
    if (result == nil) then
        return
    end
    handle:close()
    result = trim(result)

    local classpath = read_classpath()

    for path in result:gmatch("([^\n]*)\n?") do
        if (#path > 1) then
            insert_classpath_entry(classpath, path)
        end
    end

    local f = io.open(get_jdtls_workspace_dir() ..
"/jdt.ls-java-project/.classpath", "w")
    io.close(f)

    f = io.open(get_jdtls_workspace_dir() ..
"/jdt.ls-java-project/.classpath", "w")
    io.output(f)
    for key, entry in pairs(classpath) do
        io.write(entry)
    end
    io.close(f)

    vim.cmd("edit")
end

vim.api.nvim_create_user_command('UpdateClasspath', update_classpath, {})

local root_files = {
    -- Multi-module projects
    { '.git', 'build.gradle', 'build.gradle.kts' },
    -- Single-module projects
    {
        'build.xml', -- Ant
        'pom.xml', -- Maven
        'settings.gradle', -- Gradle
        'settings.gradle.kts', -- Gradle
    },
}

require('lspconfig.configs').jdtls = {
    default_config = {
        cmd = {
            'jdtls',
            '-configuration',
            get_jdtls_config_dir(),
            '-data',
            get_jdtls_workspace_dir(),
            get_jdtls_jvm_args(),
        },
        filetypes = { 'java' },
        root_dir = function(fname)
            for _, patterns in ipairs(root_files) do
                local root = util.root_pattern(unpack(patterns))(fname)
                if root then
                    return root
                end
            end
        end,
        single_file_support = true,
        init_options = {
            workspace = get_jdtls_workspace_dir(),
            jvm_args = {},
            os_config = nil,
        },
        handlers = {
            -- Due to an invalid protocol implementation in the jdtls we
have to conform these to be spec compliant.
            -- https://github.com/eclipse/eclipse.jdt.ls/issues/376
            ['textDocument/codeAction'] = on_textdocument_codeaction,
            ['textDocument/rename'] = on_textdocument_rename,
            ['workspace/applyEdit'] = on_workspace_applyedit,
            ['language/status'] = vim.schedule_wrap(on_language_status),
        },
        settings = {
            java = {
                signatureHelp = { enabled = true },
                autobuild = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
                import = {
                    gradle = {
                        enabled = true,
                        wrapper = { enabled = false }
                    }
                }
            }
        }
    },
}
