return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    -- The plugin's built-in default is `gpt-4.1`, which GitHub now ships with
    -- `model_picker_enabled = false`. CopilotChat filters those out, so the
    -- default errors with "Model not found: gpt-4.1". Pick a selectable model.
    -- See `:CopilotChatModels` for the current list.
    model = "claude-sonnet-4.6",
    -- window = {
    --   layout = "float",
    --   width = 0.5,
    --   height = 0.7,
    -- },
    -- auto_insert_mode = true,
  },
  -- NOTE: do not define `config` here. Lazy's default config is what calls
  -- `require("CopilotChat").setup(opts)`, and defining our own would replace it,
  -- leaving the prompt commands (CopilotChatFix, CopilotChatExplain, ...) unregistered.
  -- `init` runs at startup and is the right place for a FileType autocmd.
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "copilot-chat",
      callback = function()
        vim.schedule(function()
          pcall(vim.api.nvim_buf_del_keymap, 0, "n", "<C-l>")
          pcall(vim.api.nvim_buf_del_keymap, 0, "i", "<C-l>")
        end)
        -- -- rebind map <leader>cc to clear chat
        -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>cc", "<cmd>CopilotChatClear<CR>", { noremap = true, silent = true })
      end,
      desc = "Unbind <C-l> in copilot-chat after all mappings are set",
    })
  end,
}
