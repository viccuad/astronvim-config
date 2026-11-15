---@type LazySpec
---
--- By default, rustaceanvim wants dap to be always ready. For that, it builds
--- all runnables one after the other.
--- Being dap, it doesn't follow our `--profile rust-analyzer` that only runs
--- `cargo check`, but is a full `cargo build` and `cargo test --no-run`.
---
--- In small crates this is fine, but large workspaces crate full CPU work and
--- easily 100 GBs of disk for a debuger that we didn't start.
---
--- Disable it by default. Even if with autoload_configurations off, ``:RustLsp
--- debuggables` still works, it builds only the target that you select when
--- you select it.
return {
  "mrcjkb/rustaceanvim",
  opts = { dap = { autoload_configurations = false } },
}
