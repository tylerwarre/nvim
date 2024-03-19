local o = vim.opt

o.number	    = true
o.relativenumber    = true
o.autoindent	    = true
o.tabstop 	    = 8
o.softtabstop	    = 4
o.shiftwidth	    = 4
o.expandtab	    = true
o.belloff	    = "all"
o.incsearch	    = true
o.scrolloff	    = 8
o.signcolumn	    = "yes"
o.hidden	    = true
o.termguicolors     = true
o.background        = "dark"
o.hlsearch          = true
o.incsearch         = true
o.guicursor         = ""
o.mouse             = ""
vim.g.python3_host_prog = vim.fn.expand("$HOME/.config/nvim/nvim-venv/bin/python")
