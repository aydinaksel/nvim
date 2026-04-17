return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "terraform", "lua", "rust", "apex", "html", "css", "python",
          "javascript", "soql", "sosl", "sql",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end
  }
}
