-- Follow the GNOME light/dark system theme.
--
-- `auto-dark-mode.nvim` listens to the XDG desktop portal setting
-- `org.freedesktop.appearance color-scheme` and calls one of the two functions
-- below when the value changes. Catppuccin then reloads itself, because Vim
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
      -- Use the explicit flavour names. The plain name `catppuccin` selects the
      -- theme that Neovim 0.12 ships in `$VIMRUNTIME`, not the plugin. See the
      -- comment block in `plugins/catppuccin.lua`.
      -- `catppuccin-mocha` carries the Monokai Pro color overrides.
      -- `catppuccin-latte` is the original light flavour.
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme "catppuccin-mocha"
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme "catppuccin-latte"
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
