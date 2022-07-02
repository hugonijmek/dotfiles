local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer, close and reopen Neovim."
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically reload neovim whenever we save plugins.lua
-- TODO: change this to lua syntax
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

local function get_config(name)
    return string.format('require("hugonijmek/setup/%s")', name)
end

-- Install plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    -- theme
    --use {
    --    "navarasu/onedark.nvim",
    --    config = get_config("onedark")
    --}

    use {
        "folke/tokyonight.nvim", { branch = "main" },
        config = get_config("tokyonight")
    }

    -- status bar
    use {
        'nvim-lualine/lualine.nvim',
        config = get_config("lualine"),
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- lsp
    use {
        'williamboman/nvim-lsp-installer',
        requires = { 'neovim/nvim-lspconfig' },
        config = get_config('lsp'),
    }

    -- text completion
    use {
        "hrsh7th/nvim-cmp",
        config = get_config("nvim-cmp")
    }
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"

    use {
        "windwp/nvim-autopairs",
        config = get_config("autopairs")
    }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = get_config("tree-sitter"),
        run = ':TSUpdate'
    }

    -- github copilot
    --use {
    --    "github/copilot.vim"
    --}
    use {
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function()
            vim.defer_fn(function()
                require("copilot").setup {}
            end, 100)
        end,
    }
    use {
        "zbirenbaum/copilot-cmp",
        module = "copilot_cmp",
    }

    use {
        "simrat39/rust-tools.nvim",
        config = get_config("rust-tools"),
    }

    --automatically sync on bootstrapping
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
