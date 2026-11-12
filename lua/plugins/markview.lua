return {
  {
    "OXY2DEV/markview.nvim",
    opts = {
      preview = {
        -- reduce text "jumping around" when moving the cursor. default 150ms
        debounce = 10,
      },
      -- remove padding in all markdown. Rendered text matches plaintext
      -- besides the rendering:
      markdown = {
        code_blocks = {
          pad_amount = 0,
        },
        list_items = {
          shift_width = 0,
          marker_minus = { add_padding = false },
          marker_plus = { add_padding = false },
          marker_star = { add_padding = false },
          marker_dot = { add_padding = false },
          marker_parenthesis = { add_padding = false },
        },
      },
    },
  },
}
