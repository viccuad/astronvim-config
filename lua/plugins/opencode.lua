-- Move opencode.nvim mappings from <Leader>O to <Leader>o.
-- octo.nvim keeps <Leader>O. Both community packs use the same prefix,
-- and opencode loads last, so it overwrites the shared octo sub-keys.
--
-- The astrocommunity pack targets opencode.nvim v1. On the main branch (v2),
-- prompts go to the most recently updated session for the Neovim cwd, not to
-- the TUI that is open. The TUI toggle opens that same session, so the answers
-- of <Leader>oa show in it.
--
-- opencode.nvim has no option to target a session in another directory, so
-- this file wraps Server.resolve_session and Context.format. A session that
-- you choose is pinned for the cwd. Context paths become relative to the
-- directory of that session, because the agent resolves them there.

---@type table<string, opencode.server.Session>
local pinned = {}

---@type snacks.win?
local tui

---@param cmd string[]
---@param cwd? string
local function open_tui(cmd, cwd)
  tui = require("snacks.terminal").open(cmd, { cwd = cwd, win = { position = "right", enter = false } })
end

---@param server opencode.server.Server
---@return Promise<opencode.server.Session?> session `nil` to follow the latest session in the cwd.
local function choose_session(server)
  local Promise = require "opencode.promise"
  local cwd = vim.fn.getcwd()
  return server
    :request("/api/session?order=desc&parentID=null&limit=50", "GET")
    :next(function(response)
      local items = { { follow = true } }
      for _, session in ipairs(response and response.data or {}) do
        if not (session.time and session.time.archived) then table.insert(items, session) end
      end
      return require("opencode.promise.ui").select(items, {
        prompt = "OpenCode session: ",
        format_item = function(item)
          if item.follow then return "Latest session in " .. vim.fn.fnamemodify(cwd, ":~") end
          return item.title .. "  " .. vim.fn.fnamemodify(item.location.directory, ":~")
        end,
      })
    end)
    :next(function(item)
      pinned[cwd] = not item.follow and item or nil
      return Promise.resolve(pinned[cwd])
    end)
end

local function select_session()
  require("opencode.server.discovery")
    .get()
    :next(choose_session)
    :next(function(session)
      local target = session and session.title or "latest session in the cwd"
      vim.notify("OpenCode targets " .. target, vim.log.levels.INFO, { title = "opencode" })
    end)
    :catch(function(err)
      if err then vim.notify(err, vim.log.levels.ERROR, { title = "opencode" }) end
    end)
end

local function patch_plugin()
  local Promise = require "opencode.promise"
  local Server = require "opencode.server"
  local resolve_session = Server.resolve_session
  Server.resolve_session = function(self)
    local session = pinned[vim.fn.getcwd()]
    if session then return Promise.resolve(session) end
    return resolve_session(self):catch(function(err)
      if not err then return Promise.reject() end
      return choose_session(self):next(
        function(chosen) return chosen and Promise.resolve(chosen) or Promise.reject(err) end
      )
    end)
  end

  local Context = require "opencode.context"
  local format = Context.format
  Context.format = function(opts)
    local session = pinned[vim.fn.getcwd()]
    if session and opts.rel then opts = vim.tbl_extend("force", opts, { rel = session.location.directory }) end
    return format(opts)
  end
end

local function toggle_tui()
  if tui and tui:buf_valid() then
    tui:toggle()
    return
  end
  require("opencode.server.discovery")
    .get()
    :next(function(server) return server:resolve_session() end)
    :next(function(session) open_tui({ "opencode", "--session", session.id }, session.location.directory) end)
    :catch(function(err)
      -- server.start can already have opened the TUI. A nil err is a cancelled picker.
      if err and not (tui and tui:buf_valid()) then open_tui { "opencode" } end
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
    config = patch_plugin,
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
      maps.n[new .. "c"] = { select_session, desc = "Choose target session" }

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
