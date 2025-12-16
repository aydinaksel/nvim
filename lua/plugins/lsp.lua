return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        gopls = {},
        html = {},
        cssls = {},
        ruff = {},
        lua_ls = {},
        quick_lint_js = {},
        rust_analyzer = {},
        apex_ls = {
          cmd = {
            "java",
            "-jar",
            vim.fn.expand("~/.local/bin/apex-jorje-lsp.jar"),
          },
          filetypes = { "apex" },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config[server] = config
      end

      vim.lsp.enable(vim.tbl_keys(servers))

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.json",
        callback = function()
          vim.cmd([[%!jq '.' ]])
        end,
      })
    end,
  }
}
