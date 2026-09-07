-- Neovim Config 2025

-- Load settings
require("config")

-- ============================================================================
-- LAZY.NVIM BOOTSTRAP
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load and setup plugins
local plugins = require("plugins")
require("lazy").setup(plugins)

-- Load keybindings (after plugins are loaded)
require("keybindings")
