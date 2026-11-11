---@type LazySpec
return {
  {
    "CoreyKaylor/diffbandit.nvim",
    cmd = {
      "DiffBandit",
      "DiffBanditBuffers",
      "DiffBanditFolderDiff",
      "DiffBanditGit",
      "DiffBanditGitCurrent",
      "DiffBanditCommitPanel",
      "DiffBanditGitMenu",
      "DiffBanditGitLog",
      "DiffBanditGitCommit",
      "DiffBanditGitCompare",
      "DiffBanditGitCheckout",
      "DiffBanditMerge",
      "DiffBanditClose",
      -- Required by the standalone `bin/diffbandit` launcher.
      "DiffBanditLaunch",
    },
    opts = {},
  },
}
