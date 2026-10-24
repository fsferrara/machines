return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "mason-org/mason.nvim" },
  branch = "main",
  -- Match LazyVim's 0.11 compatibility pin even during the initial bootstrap.
  commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
  opts = { install_dir = vim.fn.stdpath("data") .. "/site" },
  build = function()
    -- Finish CLI provisioning before LazyVim config can request it a second time.
    local done, installed, err = false, false, nil
    LazyVim.treesitter.ensure_treesitter_cli(function(ok, message)
      installed, err, done = ok, message, true
    end)
    assert(vim.wait(300000, function() return done end, 100), "Treesitter CLI installation timed out")
    assert(installed, err)
    assert(LazyVim.treesitter.check(), "Treesitter build prerequisites are missing")
    require("nvim-treesitter").update(nil, { summary = true }):wait(300000)
  end,
}
