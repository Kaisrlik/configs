-- Workaround to make sure provider is there: https://github.com/neovim/neovim/discussions/36368
vim.g.loaded_python3_provider = nil
vim.g.python3_host_prog = '/run/current-system/sw/bin/python3'
vim.cmd('runtime autoload/provider/python3.vim')

require('xeri.nvim_cnf')
require('xeri.lazy')
require('xeri.lsp')
require('xeri.colors')
require('xeri.treesitter')
require('xeri.nvim-cmp')
require('xeri.dap')
require('xeri.telescope')
require('xeri.codecomp')
