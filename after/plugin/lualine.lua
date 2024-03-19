local function get_venv()
    if vim.bo.filetype ~= "python" then
        return ""
    end

    local venv = os.getenv("VIRTUAL_ENV")
    if venv ~= nil and string.find(venv, "/") then
        local orig_venv = venv
        for w in orig_venv:gmatch("([^/]+)") do
            venv = w
        end
        venv = string.format("%s", venv)
        return venv
    else
        return ""
    end
end

local function get_progress()
    local cur = vim.fn.line('.')
    local total = vim.fn.line('$')
    if cur == 1 then
        return '(Top)'
    elseif cur == total then
        return '(Bot)'
    else
        return string.format('(%2d%%%%)', math.floor(cur / total * 100))
    end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {get_venv, 'filetype'},
    lualine_y = {'encoding'},
    lualine_z = {'searchcount', 'selectioncount', {get_progress, separator="", padding={left=1,right=0}}, {'location', padding={left=0,right=1}}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
