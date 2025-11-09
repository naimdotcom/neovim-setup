# My Neovim Config

This repository contains my personal Neovim configuration.  
It is designed for **modern development** with features like LSP, auto-completion, snippets, file explorer, bufferline, and more.  
I use **lazy.nvim** as the plugin manager.

---

## Features

**LSP + Mason** — Easy language server management for:

- JavaScript / TypeScript
- Python
- C / C++
- Lua

**Auto-completion**

- `nvim-cmp` for completion
- `LuaSnip` for snippets
- Friendly community snippets

**File explorer**

- `neo-tree.nvim` for side file navigation

**Buffer management**

- `bufferline.nvim` with clean buffer tabs

**Status line**

- `lualine.nvim` with icon support via `nvim-web-devicons`

**Fuzzy finder**

- `telescope.nvim` with `ui-select` extension

**Formatting / linting**

- `none-ls.nvim` (formerly null-ls) for formatters and linters

**Syntax highlighting**

- `nvim-treesitter` for advanced syntax parsing

**Auto-pairs**

- `nvim-autopairs` for automatic bracket/quote pairs

**Dashboard**

- `alpha-nvim` for a nice startup screen

**Theme**

- `moonfly` and `windsurf.vim` (custom theme options)

---

## Key Plugins & Versions

| Plugin          | Branch | Commit                                   |
| --------------- | ------ | ---------------------------------------- |
| lazy.nvim       | main   | 6c3bda4aca61a13a9c63f1c1d1b16b9d3be90d7a |
| neo-tree.nvim   | v3.x   | f481de16a0eb59c985abac8985e3f2e2f75b4875 |
| bufferline.nvim | main   | 655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3 |
| lualine.nvim    | master | a94fc68960665e54408fe37dcf573193c4ce82c9 |
| nvim-cmp        | main   | b5311ab3ed9c846b585c0c15b7559be131ec4be9 |
| LuaSnip         | master | eda5be8f0ce9816278671f0b578cdbb8b762c701 |
| nvim-lspconfig  | master | 6bba673aa8993eceec233be17b42ddfb9540794b |
| none-ls.nvim    | main   | db2a48b79cfcdab8baa5d3f37f21c78b6705c62e |
| telescope.nvim  | master | a0bbec21143c7bc5f8bb02e0005fa0b982edc026 |
| nvim-treesitter | master | 42fc28ba918343ebfd5565147a42a26580579482 |

**And more... (see `lazy-lock.json`)**

---

## How to Use

```bash
git clone https://github.com/naimdotcom/neovim-setup.git
```

## Keyboard Shortcuts

Below are all custom key mappings configured in this setup.

| Key          | Mode            | Description                    |
| ------------ | --------------- | ------------------------------ |
| `<Space>`    | —               | Leader key                     |
| `<S-l>`      | Normal          | Next buffer                    |
| `<S-h>`      | Normal          | Previous buffer                |
| `<C-p>`      | Normal          | Find files (Telescope)         |
| `<leader>fg` | Normal          | Live grep (Telescope)          |
| `K`          | Normal          | Show hover documentation (LSP) |
| `gd`         | Normal          | Go to definition (LSP)         |
| `gr`         | Normal          | Show references (LSP)          |
| `<leader>rn` | Normal          | Rename symbol (LSP)            |
| `<leader>ca` | Normal / Visual | Code actions (LSP)             |
| `<leader>gf` | Normal          | Format file (None-LS)          |
| `<C-n>`      | Normal          | Toggle Neo-tree file explorer  |
| `<Tab>`      | Insert          | Next completion item           |
| `<S-Tab>`    | Insert          | Previous completion item       |
| `<CR>`       | Insert          | Confirm completion             |
| `<C-Space>`  | Insert          | Trigger completion manually    |
| `<C-b>`      | Insert          | Scroll docs up                 |
| `<C-f>`      | Insert          | Scroll docs down               |
| `<C-e>`      | Insert          | Abort completion               |
| `<C-g>`      | Insert          | Accept Codeium suggestion      |
| `<C-;>`      | Insert          | Next Codeium suggestion        |
| `<C-,>`      | Insert          | Previous Codeium suggestion    |
| `<C-x>`      | Insert          | Clear Codeium suggestion       |


## Notes

Code formatting runs automatically on save.

Neo-tree closes automatically when quitting Neovim.

You can customize shortcuts easily under lua/plugins/*.lua.

Default Telescope bindings (like / search, recent files, etc.) are still available.
