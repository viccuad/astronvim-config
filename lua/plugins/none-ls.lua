-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    -- local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
    })

    -- Keep null-ls temp files out of the project tree.
    -- For tools that cannot read stdin (e.g. `deadnix`), null-ls writes the
    -- buffer to `.null-ls_<rand>_<name>` *next to the original file* and only
    -- removes it once the process finishes. If the command fails to spawn or
    -- nvim exits uncleanly, the file is orphaned in the repo.
    opts.sources = vim.tbl_map(function(source)
      if source._opts and source._opts.to_temp_file then
        return source.with { temp_dir = vim.fn.stdpath "cache" }
      end
      return source
    end, opts.sources or {})
  end,
}
