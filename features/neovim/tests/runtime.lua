local function check()
  assert(vim.fn.has("nvim-0.11.2") == 1 and jit, "Neovim >= 0.11.2 with LuaJIT required")
  vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
  assert(vim.g.mapleader == " ", "Space leader")
  assert(vim.o.number and not vim.o.relativenumber, "absolute line numbers")
  assert(vim.g.autoformat == false, "autoformat disabled")
  assert(vim.o.background == "dark" and vim.g.colors_name == "tokyonight-night", "static dark theme")
  assert(vim.o.clipboard == (vim.env.SSH_CONNECTION and "" or "unnamedplus"), "native clipboard option")
  assert(vim.g.clipboard == nil, "no custom clipboard provider")
  assert(Snacks.config.scroll.enabled == false, "animated scrolling disabled")
  assert(not Snacks.config.explorer.enabled, "no competing Snacks explorer")

  local plugins = require("lazy.core.config").plugins
  assert(plugins["neo-tree.nvim"], "Neo-tree installed")
  assert(vim.fn.maparg(" e", "n", false, true).desc:find("NeoTree"), "Neo-tree leader mapping")
  for _, key in ipairs({ "  ", " sg", " bd", " bo", " gg", " uw", "<S-h>", "<S-l>" }) do
    assert(vim.fn.maparg(key, "n") ~= "", "missing mapping: " .. key)
  end
  vim.cmd("Neotree show")
  assert(vim.wait(10000, function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
        return true
      end
    end
    return false
  end, 100), "Neo-tree opens")
  vim.cmd("Neotree close")

  require("lazy").load({ plugins = { "nvim-treesitter" } })
  assert(vim.wait(300000, function()
    return vim.fn.executable("tree-sitter") == 1
  end, 100), "Treesitter CLI installation timed out; inspect :Mason")
  local languages = LazyVim.opts("nvim-treesitter").ensure_installed
  require("nvim-treesitter").install(languages):wait(300000)
  for _, language in ipairs(languages) do
    assert(#vim.treesitter.get_string_parser("", language):parse() > 0, "missing parser: " .. language)
  end
  vim.cmd("enew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "local answer = 42", "return answer" })
  local parser = vim.treesitter.get_parser(0, "lua")
  assert(parser:parse()[1]:root():type() == "chunk", "Lua parser works")

  for name, plugin in pairs(plugins) do
    assert(plugin._.installed, "missing plugin: " .. name)
    for _, task in ipairs(plugin._.tasks or {}) do
      assert(not task:has_errors(), name .. ": " .. task:output())
    end
  end
  assert(vim.v.errmsg == "", vim.v.errmsg)
  print("PASS: editor options, Neo-tree, keymaps, native clipboard, plugins and all default parsers")
end

local ok, err = xpcall(check, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd("cquit")
else
  vim.cmd("qa!")
end
