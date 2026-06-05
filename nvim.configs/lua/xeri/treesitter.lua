require('nvim-treesitter').setup{ }

local ensure_installed = {
	"c",
	"cmake",
	"cpp",
	"bash",
	"dockerfile",
	"lua",
	"make",
	"markdown",
	"meson",
	"typst",
	"vim",
	"yaml",
}
local already_installed = require('nvim-treesitter.config').get_installed()
local parsers_to_install = vim.iter(ensure_installed)
:filter(function(parser)
	return not vim.tbl_contains(already_installed, parser)
end)
:totable()
require('nvim-treesitter').install(parsers_to_install)

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
