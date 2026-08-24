-- Follow the GNOME light/dark system theme.
--
-- `auto-dark-mode.nvim` listens to the XDG desktop portal setting
-- `org.freedesktop.appearance color-scheme` and calls one of the two functions
-- below when the value changes. astrotheme then reloads itself, because Vim
-- re-sources the colorscheme every time `background` changes.
--
-- NOTE: GNOME reports `default` (no preference) until you pick a style in
-- Settings > Appearance. The plugin reads `default` as light.

---@type LazySpec
return {
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme "monokai-pro"
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme "astrotheme"
      end,
    },
    config = function(_, opts)
      -- The plugin kills its `dbus-monitor` child on `VimLeavePre`, so a normal
      -- exit leaks nothing. A crash or `kill -9` leaves the child orphaned.
      -- `setpriv --pdeathsig TERM` makes the kernel kill the child when Neovim
      -- dies, whatever the cause.
      local interval = require "auto-dark-mode.interval"
      local start = interval.start
      ---@diagnostic disable-next-line: duplicate-set-field
      interval.start = function(options, state)
        if next(state.monitor_command) ~= nil and vim.fn.executable "setpriv" == 1 then
          state.monitor_command = vim.list_extend({ "setpriv", "--pdeathsig", "TERM" }, state.monitor_command)
        end
        return start(options, state)
      end
      require("auto-dark-mode").setup(opts)
    end,
  },
}
