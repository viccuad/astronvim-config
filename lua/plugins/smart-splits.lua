-- smart-splits.nvim: Ctrl+h/j/k/l moves between Neovim windows, and, at
-- the edge of the Neovim layout, moves to the next zellij pane instead.
-- With zellij_move_focus_or_tab, it also crosses into the next/previous
-- zellij tab when there is no further pane to move to on the left/right.
--
-- Companion piece: the "nvim-nav" zellij plugin (see the dotfiles repo,
-- zellij/.config/zellij/config.kdl) checks the focused pane's running
-- command on Ctrl+h/j/k/l. Inside Neovim, it forwards the raw keystroke
-- here. Elsewhere (a plain shell, k9s, and so on), it moves zellij's own
-- pane/tab focus directly with move-focus-or-tab, matching this option.
--
-- zellij itself must NOT bind Ctrl+h/j/k/l on its own: a zellij keybind
-- would consume the key before Neovim ever receives it, breaking this.

---@type LazySpec
return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      multiplexer_integration = "zellij",
      zellij_move_focus_or_tab = true,
    },
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left window, zellij pane, or tab" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below window or zellij pane" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above window or zellij pane" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right window, zellij pane, or tab" },
    },
  },
}
