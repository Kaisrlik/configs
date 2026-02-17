require('nvim-treesitter.configs').setup{
	-- enable syntax highlighting
	highlight = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
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
	},
	ignore_install = {
		"gitcommit",
	},
	-- auto install above language parsers
	auto_install = true,
}
