# Neovim Configuration (2025/26)

A high-performance, modular, and IDE-like Neovim setup using Lua and **Lazy.nvim**.

## 🚀 Key Features

- **Neovim 0.11+ Ready**: Uses the new `vim.lsp.enable()` and `vim.lsp.config()` patterns.
- **Aesthetics**: **TokyoNight** (Night style) with **Lualine** for a clean status bar.
- **IDE Intelligence**: 
  - **LSP**: Integrated with **Mason** for automatic server management (`lua_ls`, `pyright`).
  - **Completion**: VS Code-like autocomplete with **nvim-cmp** and snippets via **LuaSnip**.
  - **Syntax**: **TreeSitter** for superior highlighting and structural understanding.
- **Navigation**:
  - **Telescope**: Optimized fuzzy finder (lazy-loaded on use).
  - **NvimTree**: Sidebar file explorer.
- **Clipboard**: Seamless integration with the system clipboard (`unnamedplus`).

## 📂 File Structure

- `init.lua`: Main entry point and plugin bootstrapping.
- `lua/config.lua`: Core Vim options (tabs, numbers, mouse, etc.).
- `lua/plugins.lua`: Plugin definitions and configurations.
- `lua/keybindings.lua`: Custom mappings and shortcuts.

## ⌨️ Essential Mappings

- `<leader>e`: Toggle File Explorer (NvimTree)
- `<leader>ff`: Find Git Files (Telescope)
- `<leader>fa`: Find All Files (Telescope)
- `<leader>fg`: Live Grep / Search Text (Telescope)
- `<leader>fb`: Switch Buffers (Telescope)
- `<C-Space>`: Trigger autocomplete menu
- `<Tab>` or `<CR>`: Select completion item

*Note: Default leader is `\` (backslash).*

## 🛠️ Maintenance

- `:Lazy`: Manage, update, and profile plugins.
- `:Mason`: Install and update Language Servers (LSPs).
- `:TSUpdate`: Update TreeSitter grammars.

