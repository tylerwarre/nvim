local export = {}

local enabled_langs = {
	"c",
	"cpp",
	"lua",
	"python"
}

for _, lang in ipairs(enabled_langs) do
	local status, module = pcall(require, "languages." .. lang)
	if status then
		table.insert(export, { name = lang, module = module })
	end
end

return export
