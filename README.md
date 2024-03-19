# TODO
- Configure nvim-dap to use DAPs from mason
- https://github.com/rcarriga/nvim-notify
- https://github.com/stevearc/dressing.nvim
- https://github.com/mbbill/undotree
- https://github.com/nvim-lualine/lualine.nvim

    reuse lualine filetype icon & name. also how to set component options ([https://github.com/nvim-lualine/lualine.nvim/issues/475](https://github.com/nvim-lualine/lualine.nvim/issues/475)

    if filetype = python show venv based on PATH, not VENV env var
- https://github.com/tpope/vim-fugitive
- Skeleton files (pentest checklists, launch.json, python package, pyrightconfig.json) lua-snip? (https://github.com/L3MON4D3/LuaSnip) or (https://github.com/molleweide/LuaSnip-snippets.nvim)
- https://github.com/danymat/neogen
- ~~https://github.com/ellisonleao/gruvbox.nvim~~
# File Tree
```
├── after
│   └── plugin
│       ├── gruvbox.lua
│       ├── lsp.lua
│       ├── nvim-dap.lua
│       ├── nvim-tree.lua
│       ├── python.lua
│       ├── telescope.lua
│       └── treesitter.lua
├── init.lua
└── lua
    └── modules
        ├── init.lua
        ├── mappings.lua
        ├── options.lua
        └── vim-plug.lua
```
