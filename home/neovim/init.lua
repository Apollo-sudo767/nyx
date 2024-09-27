-- Basic Neovim settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.shiftwidth = 4           -- Shift by 4 spaces
vim.opt.tabstop = 4              -- Tab size of 4 spaces
vim.opt.termguicolors = true     -- Enable true colors
vim.opt.splitright = true        -- Open vertical splits to the right
vim.opt.splitbelow = true        -- Open horizontal splits below

-- Add Nix store path to runtimepath to recognize plugins installed via Nix
vim.opt.runtimepath:append("/nix/store")

-- Load and configure plugins

-- 1. nvim-surround
require('nvim-surround').setup({})

-- 2. fzf-vim (for fuzzy finding)
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true, silent = true })

-- 3. nvim-lspconfig (for language server support)
local lspconfig = require('lspconfig')

-- Example: Set up language servers for Python and Lua
lspconfig.pyright.setup{}    -- Python
lspconfig.sumneko_lua.setup{ -- Lua
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
}

-- 4. dashboard-nvim (start screen)
require('dashboard').setup {
    header = { "Welcome to Neovim" },
    footer = { "Enjoy coding!" },
    bookmarks = {
        { description = "Open init.lua", command = "edit ~/.config/nvim/init.lua" },
    }
}

-- 5. lspsaga-nvim (LSP UI enhancements)
require('lspsaga').setup({})

-- 6. feline-nvim (statusline)
require('feline').setup()

-- 7. nvim-cokeline (bufferline)
require('cokeline').setup({})

-- 8. nerdtree (file explorer)
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 9. floaterm (floating terminal)
vim.api.nvim_set_keymap('n', '<leader>t', ':FloatermToggle<CR>', { noremap = true, silent = true })

-- 10. tokyonight-nvim (theme)
vim.cmd[[colorscheme tokyonight]]

-- Keybindings for fast navigation and utility
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })  -- Quick quit
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- Quick save
