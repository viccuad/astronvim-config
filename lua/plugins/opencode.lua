-- Move opencode.nvim mappings from <Leader>O to <Leader>o.
-- octo.nvim keeps <Leader>O. Both community packs use the same prefix,
-- and opencode loads last, so it overwrites the shared octo sub-keys.
--
-- The astrocommunity pack targets opencode.nvim v1. On the main branch (v2),
-- prompts go to the most recently updated session for the Neovim cwd, not to
-- the TUI that is open. The TUI toggle opens that same session, so the answers
-- of <Leader>oa show in it.

---@type snacks.win?
local tui

---@param cmd string[]
local function open_tui(cmd) tui = require("snacks.terminal").open(cmd, { win = { position = "right", enter = false } }) end

local function toggle_tui()
  if tui and tui:buf_valid() then
    tui:toggle()
    return
  end
  require("opencode.server.discovery")
    .get()
    :next(function(server) return server:resolve_session() end)
    :next(function(session) open_tui { "opencode", "--session", session.id } end)
    :catch(function()
      -- server.start can already have opened the TUI.
      if not (tui and tui:buf_valid()) then open_tui { "opencode" } end
    end)
end

return {
  {
    "NickvanDyke/opencode.nvim",
    branch = "main",
    version = false,
    init = function()
      vim.g.opencode_opts = {
        server = {
          start = function() open_tui { "opencode" } end,
        },
      }
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      local old, new = "<Leader>O", "<Leader>o"

      -- Move the opencode mappings to the new prefix.
      maps.n[new] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
      maps.v[new] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
      for _, suffix in ipairs { "a", "e", "s" } do
        maps.n[new .. suffix] = maps.n[old .. suffix]
      end
      for _, suffix in ipairs { "a", "s" } do
        maps.v[new .. suffix] = maps.v[old .. suffix]
      end
      for _, suffix in ipairs { "", "a", "+", "s" } do
        maps.v[old .. suffix] = false
      end
      maps.n[new .. "t"] = { toggle_tui, desc = "Toggle TUI on target session" }

      -- These pack mappings call v1 APIs that v2 does not have: toggle(),
      -- prompt() with append, and the session.new and session.half.page.*
      -- TUI commands.
      maps.n[old .. "+"] = false
      maps.n[old .. "n"] = false
      maps.n["<S-C-u>"] = false
      maps.n["<S-C-d>"] = false

      -- Restore the octo.nvim group labels that opencode overwrote.
      maps.n[old] = { desc = require("astroui").get_icon("Octo", 1, true) .. "Octo" }
      maps.n[old .. "a"] = { desc = "Assignee/Reviewer" }
      maps.n[old .. "e"] = { desc = "Reaction" }
      maps.n[old .. "s"] = { desc = "Review" }
      maps.n[old .. "t"] = { desc = "Threads" }
    end,
  },
}
