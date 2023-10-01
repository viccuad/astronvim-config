return {
  {
    "NeogitOrg/neogit",
    setup = { -- TODO setup doesn't work
       mappings = {
        -- modify status buffer mappings
        status = {
          ["F"] = "PullPopup",
          ["p"] = "PushPopup",
        }
      },
      integrations = {
        -- requires sindrets/diffview.nvim installed, which is installed from community
        diffview = enabled,
      },
      sections = {
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
      },
    },
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Open Neogit" },
    },
  },
}
