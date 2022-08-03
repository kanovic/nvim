-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/plugins.lua
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")

if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Plugins
return packer.startup(function(use)
	-- Plugins list
  use "nvim-lua/popup.nvim" -- an implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- useful lua functions used ny lots of plugins	
	use "windwp/nvim-autopairs" -- autopairs, integrates with both cmp and treesitter
	use "numToStr/Comment.nvim" -- easily comment stuff
	use {
  'kyazdani42/nvim-tree.lua', -- nvim_tree
  requires = {
    'kyazdani42/nvim-web-devicons', -- for nvim_tree file icons
	  },
	}
  use "akinsho/bufferline.nvim" -- bufferline
	use "moll/vim-bbye" -- delete buffers and close files without closing your windows or messing up layout
	-- package manager
	use("wbthomason/packer.nvim")
	-- colorscheme
	use("dracula/vim")
	-- completions
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
	-- snippets
	use("L3MON4D3/LuaSnip")
  -- lsp
  use "neovim/nvim-lspconfig" -- enable lsp
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  -- telescope
  use "nvim-telescope/telescope.nvim"
	-- treesitter
	use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
	use "p00f/nvim-ts-rainbow"
	use "JoosepAlviste/nvim-ts-context-commentstring"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
