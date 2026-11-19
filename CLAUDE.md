# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal Neovim config (Neovim 0.12+). No plugin manager framework — everything uses built-in APIs.

The setup aims to be plugin sparse and to not change the core functionality of vim too much. 

## Checking changes

There is no build or test suite. To verify a change loads without errors:

```sh
nvim --headless +qa    # startup errors print to stderr
```

Use `:checkhealth vim.lsp` inside Neovim to inspect LSP state.

`<leader>con` opens this directory in Oil from inside Neovim.

## Architecture

- **`init.lua`** is the only entry point and explicitly `require`s every module. A new file under `lua/config/` or `lua/plugins/` does nothing until it is added here. Order matters: `config.globals` (sets `mapleader` to space) must load before anything defining `<leader>` maps.
- **Plugins** use the built-in `vim.pack.add({ { src = ... } })` — not lazy.nvim/packer. Each `lua/plugins/<name>.lua` calls `vim.pack.add` for its plugin(s) and then configures them inline (setup, keymaps). Pinned revisions live in `nvim-pack-lock.json`, which `vim.pack` maintains; don't hand-edit it.
- **LSP** uses native `vim.lsp.config`/`vim.lsp.enable`. Per-server configs are files in `lsp/<server>.lua` returning a config table (auto-discovered by name); a server only starts if listed in `vim.lsp.enable({...})` in `lua/config/lsp.lua`. (`lsp/yamlls.lua` exists but is not currently enabled.) Server binaries are expected on `$PATH` — there is no Mason.
- **Colorschemes** are hand-written Lua files in `colors/` (loaded via `vim.cmd.colorscheme('custom-...')`). `lua/config/colorschemes.lua` picks one from the `$ITERM_PROFILE` env var (light/popp/mist → light schemes, otherwise `custom-dark-redDir`), so the theme follows the iTerm2 profile.
- **Snippets** (LuaSnip, autosnippets enabled): per-filetype files in `luasnippets/<filetype>.lua` are loaded by the Lua loader. Math-mode snippets are shared between `tex` and `markdown` via `lua/snippets/math.lua`, a function taking an `in_math` predicate — tex uses VimTeX's `vimtex#syntax#in_mathzone`, markdown uses a treesitter check for `latex_block` in `markdown_inline`. Add math snippets there, not in the per-filetype files.
- **Completion**: nvim-cmp in `lua/plugins/nvim-cmp.lua`; `lua/plugins/vim-tex.lua` sets up its own tex-specific cmp sources.

## Conventions

- The user types on a Norwegian keyboard: `ø`/`æ` are remapped to `[`/`]` (so `øs`, `æd`, etc.). Prefer bracket-style mappings that work through this remap rather than mapping `[`/`]` directly in ways that bypass it.
- 4-space indentation in Lua; keymaps are set with `vim.keymap.set` near the feature they belong to (plugin-specific maps live in the plugin's file, general ones in `lua/config/keymaps.lua`).
