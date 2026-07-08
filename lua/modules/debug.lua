local export = {}

-- Forward declaration of functions
local toggle_breakpoint
local f_read_breakpoints

-- Setup
vim.api.nvim_set_hl(0, "Debug", {
	fg = "#fb4934"
})

vim.fn.sign_define("Breakpoint", {
	text = "◍",
	texthl = "Debug"
})

-- Local Functions
f_read_breakpoints = function(dbgname)
	local f = io.open(vim.fn.getcwd() .. "/" .. dbgname, "r")

	local content
	if f then
		content = f:read("*all")
		f:close()
	else
		return false
	end

	vim.fn.sign_unplace('Breakpoint', { buffer = '%' })
	local buffname = vim.fn.expand('%:t')
	for fname, lnum in string.gmatch(content, "break (.-):(%d+)") do
		if fname == buffname then
			toggle_breakpoint(lnum)
		end
	end

	return true
end

local function f_find_breakpoint(lnum, dbgname)
	local f = io.open(vim.fn.getcwd() .. "/" .. dbgname, "r")

	local content
	if f then
		content = f:read("*all")
		f:close()
	else
		return false
	end

	if content:find("break " .. vim.fn.expand('%:t') .. ":" .. lnum) then
		return true
	else
		return false
	end
end

local function f_delete_breakpoint(lnum, dbgname)
	local f = io.open(vim.fn.getcwd() .. "/" .. dbgname, "r")

	local content
	if f then
		content = f:read("*all")
		f:close()
	else
		return false
	end

	f = io.open(vim.fn.getcwd() .. "/" .. dbgname, "w")
	if f then
		content = content:gsub("break " .. vim.fn.expand('%:t') .. ":" .. lnum .. "\n", "")
		f:write(content)
		f:close()
	else
		return false
	end

	return true
end

local function f_write_breakpoint(lnum, dbgname)
	local f = io.open(vim.fn.getcwd() .. "/" .. dbgname, "a")

	-- Exit if the breakpoint already exists in file
	if f_find_breakpoint(lnum, dbgname) then
		return true
	end

	if f then
		f:write("break " .. vim.fn.expand('%:t') .. ":" .. lnum .. "\n")
		f:close()
	else
		return false
	end

	return true
end

toggle_breakpoint = function(lnum)
	local bufnr = vim.api.nvim_get_current_buf()
	if lnum == nil then
		lnum = vim.api.nvim_win_get_cursor(0)[1]
	end

	local signs = vim.fn.sign_getplaced('%', { group = 'Breakpoint', lnum = lnum })[1].signs

	local result
	local ft = vim.bo.filetype
	local status, module = pcall(require, "languages." .. ft)
	if signs[1] == nil then
		vim.fn.sign_place(0, 'Breakpoint', 'Breakpoint', bufnr, { lnum = lnum })
		if status then
			result = module.write_breakpoint(lnum)
		else
			result = f_write_breakpoint(lnum, ".breakpoints")
		end

		if result == false then
			vim.print("Unable to write breakpoint to file")
		end
	else
		vim.fn.sign_unplace('Breakpoint', { buffer = bufnr, id = signs[1].id })
		if status then
			result = module.delete_breakpoint(lnum)
		else
			result = f_delete_breakpoint(lnum, ".breakpoints")
		end

		if result == false then
			vim.print("Unable to delete breakpoint from file")
		end
	end
end


-- User Functions
vim.api.nvim_create_user_command("Break", function()
	toggle_breakpoint()
end, {})

-- Export functions
export.f_read_breakpoints = f_read_breakpoints
export.f_write_breakpoint = f_write_breakpoint
export.f_delete_breakpoint = f_delete_breakpoint

return export
