return {
  {
    "NeogitOrg/neogit",
    opts = {
      -- The time after which an output console is shown for slow running commands
      console_timeout = 5000,
      mappings = {
        -- modify popup buffer mappings
        popup = {
          ["F"] = "PullPopup",
          ["p"] = "PushPopup",
        },
      },
      sections = {
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
      },
      integrations = {
        -- Stop diffview from opening on its own when staging a
        -- conflicted file during a rebase/merge. Trade-off: Neogit's diff popup
        -- gates its actions on this flag, so `d`/`h`/`r`/`u`/`s`/`w`/`c` are no
        -- longer offered there (only `p` paths remains).
        -- Use `:DiffviewOpen`.
        diffview = false,
      },
    },
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Open Neogit" },
    },
  },
}
