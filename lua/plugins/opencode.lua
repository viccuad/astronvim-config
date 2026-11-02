-- Move opencode.nvim mappings from <Leader>O to <Leader>o.
-- octo.nvim keeps <Leader>O. Both community packs use the same prefix,
-- and opencode loads last, so it overwrites the shared octo sub-keys.
return {
  { "NickvanDyke/opencode.nvim", branch = "main", version = false },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      local old, new = "<Leader>O", "<Leader>o"

      -- Move the opencode mappings to the new prefix.
      maps.n[new] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
      maps.v[new] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
      for _, suffix in ipairs { "t", "a", "+", "e", "n", "s" } do
        maps.n[new .. suffix] = maps.n[old .. suffix]
      end
      for _, suffix in ipairs { "a", "+", "s" } do
        maps.v[new .. suffix] = maps.v[old .. suffix]
        maps.v[old .. suffix] = false
      end
      maps.v[old] = false

      -- Remove the opencode-only keys from the old prefix.
      maps.n[old .. "+"] = false
      maps.n[old .. "n"] = false

      -- Restore the octo.nvim group labels that opencode overwrote.
      maps.n[old] = { desc = require("astroui").get_icon("Octo", 1, true) .. "Octo" }
      maps.n[old .. "a"] = { desc = "Assignee/Reviewer" }
      maps.n[old .. "e"] = { desc = "Reaction" }
      maps.n[old .. "s"] = { desc = "Review" }
      maps.n[old .. "t"] = { desc = "Threads" }
    end,
  },
}
