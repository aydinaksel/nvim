return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "terraform", "lua", "rust", "apex", "html", "css", "python",
          "javascript", "soql", "sosl", "sql",
        },
        modules = {},
        ignore_install = {},
        indent = { enable = false },
        sync_install = false,
        auto_install = false,
        highlight = { enable = true },
      })
    end
  }
}
