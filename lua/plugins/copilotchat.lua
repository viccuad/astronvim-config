return {
  "CopilotC-Nvim/CopilotChat.nvim",
  config = function()
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
