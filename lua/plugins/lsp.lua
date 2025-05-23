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
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      lspconfig.gopls.setup { capabilities = capabilities }
      lspconfig.html.setup { capabilities = capabilities }
      lspconfig.cssls.setup { capabilities = capabilities }
      lspconfig.ruff.setup { capabilities = capabilities }
      lspconfig.lua_ls.setup { capabilites = capabilities }
      lspconfig.quick_lint_js.setup { capabilites = capabilities }
      lspconfig.rust_analyzer.setup {
        capabilites = capabilities,
        cmd = { "/home/aydin/.local/bin/rust-analyzer" },
      }
      lspconfig.apex_ls.setup {
        apex_jar_path = "/home/aydin/.local/bin/apex-jorje-lsp.jar",
        apex_enable_semantic_errors = false,
        apex_enable_completion_statistics = false,
        capabilites = capabilities,
        filetypes = { "apex" },
      }

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
