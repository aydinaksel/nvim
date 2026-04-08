return {
  {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local argument = vim.fn.argv(0)
          if argument == "" or vim.fn.isdirectory(argument) == 1 then
            require("oil").open()
          end
        end,
      })
    end
  },
}
