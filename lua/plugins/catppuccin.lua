-- Catppuccin, with a custom dark flavour that imitates Monokai Pro.
--
-- The base spec comes from `astrocommunity.colorscheme.catppuccin`. That spec
-- sets `auto_integrations = true`, so Catppuccin scans the lazy plugin list and
-- turns on every integration that it knows. AstroNvim merges this file into
-- that spec, so the automatic integrations stay on.
--
-- HOW THE OVERRIDE WORKS
-- `color_overrides` is merged per flavour in `catppuccin/palettes/init.lua`:
--     vim.tbl_deep_extend("keep", O.color_overrides.all or {},
--                                 O.color_overrides[flavour] or {},
--                                 palette or {})
-- The table below therefore changes `mocha` only. `latte` stays original.
--
-- Every integration file reads palette NAMES, never hex values. For example
-- `groups/integrations/diffview.lua` uses `C.blue`, `C.green`, `C.red`,
-- `C.lavender`, `C.pink`, `C.flamingo`, `C.overlay0`, `C.mantle` and `C.base`.
-- Diffview, Neogit and Octo follow these new values automatically.
--
-- LIMIT OF THE MAPPING
-- Catppuccin has 14 accent names. Monokai Pro has 6. A direct mapping makes
-- several names identical and the interface loses contrast, because many
-- integrations place two accent names next to each other. To keep the
-- interface readable, some names below are shifted variants of a Monokai
-- accent instead of an exact copy. The `-- shifted` and `-- interpolated`
-- comments mark these values.
--
-- Source palette: monokai-pro.nvim, `pro` filter
-- (lua/monokai-pro/palette/pro.lua).
--
-- NAME COLLISION WITH THE NEOVIM RUNTIME
-- Neovim 0.12 ships its own `$VIMRUNTIME/colors/catppuccin.vim`. The plugin is
-- lazy, so its own `colors/catppuccin.lua` is not on the runtime path at
-- startup. The plain name `catppuccin` therefore selects the BUILT-IN theme,
-- the plugin never loads, and the overrides below never apply.
-- For this reason `astroui.lua` and `auto-dark-mode.lua` use the explicit
-- flavour names `catppuccin-mocha` and `catppuccin-latte`. These names exist
-- only in the plugin, so lazy loads it and the overrides apply.
--
-- Catppuccin hashes the options table and recompiles its cache when the hash
-- changes. No manual `:CatppuccinCompile` is necessary after an edit here.
--
-- To confirm that the plugin integrations are on, run:
--     :lua vim.print(require("catppuccin").options.integrations)
-- Look for `diffview = true`, `neogit = true` and `octo = true`.
-- To read one applied highlight, run `:hi DiffviewFilePanelInsertions`.

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  ---@type CatppuccinOptions
  ---@diagnostic disable: missing-fields
  opts = {
    -- `astroui.lua` and `auto-dark-mode.lua` name the flavour directly, so this
    -- table is not used at present. It stays for the plain `catppuccin-nvim`
    -- entry point, which reads `vim.o.background`.
    background = {
      light = "latte", -- original Catppuccin Latte, not modified
      dark = "mocha", -- the Monokai Pro flavour defined below
    },

    -- REPAIR FOR TWO INTEGRATIONS THAT AUTO-DETECTION TURNS OFF
    -- `auto_integrations` returns the boolean `true` for a plugin whose
    -- Catppuccin default is not a table (`lib/detect_integrations.lua:64-77`).
    -- Catppuccin then merges the user table over that boolean with
    -- `vim.tbl_deep_extend("force", ...)` (`init.lua:154-160`). The merge
    -- REPLACES the boolean with the table, and the table has no `enabled` key.
    -- The mapper skips any integration without `enabled == true`
    -- (`lib/mapper.lua:42-52`), so the integration never runs.
    --
    -- The AstroCommunity spec passes exactly such a table for `snacks` and
    -- `colorful_winsep`. Both integrations were therefore off.
    --
    -- The visible result for `snacks`: the indent guides fell back to the
    -- Snacks defaults (`snacks.nvim/lua/snacks/indent.lua:105-118`), which link
    -- `SnacksIndent` to `NonText` (`#727072`) and `SnacksIndentChunk` to
    -- `Special` (`#ff8ba7`). Those colors are bright, so the guides looked like
    -- separators between blocks of code. With the integration on, Catppuccin
    -- sets `SnacksIndent` to `C.surface0` and the guides become subtle.
    --
    -- `enabled = true` restores both.
    integrations = {
      snacks = { enabled = true, indent_scope_color = "surface2" },
      colorful_winsep = { enabled = true, color = "surface2" },
    },
    color_overrides = {
      mocha = {
        -- Backgrounds, from the darkest to the editor background.
        crust = "#19181a", -- monokai dark2
        mantle = "#221f22", -- monokai dark1
        base = "#2d2a2e", -- monokai background

        -- Raised surfaces: floats, cursor line, selections, borders.
        -- `surface1` is the float and popup background. Monokai Pro uses
        -- `dimmed5` there (`monokai-pro/theme/scheme.lua:238-244`), so the
        -- value is exact. `surface0` is an interpolated step below it.
        surface0 = "#3a373b", -- interpolated (no monokai equivalent)
        surface1 = "#403e41", -- monokai dimmed5
        surface2 = "#5b595c", -- monokai dimmed4

        -- Muted foregrounds: comments, borders, inactive text.
        -- `overlay2` drives the `Comment` group, so it stays at the Monokai
        -- value. A lighter value makes comments compete with the code.
        overlay0 = "#727072", -- monokai dimmed3
        overlay1 = "#838283", -- interpolated
        overlay2 = "#939293", -- monokai dimmed2

        -- Main foregrounds.
        subtext0 = "#aaa9aa", -- interpolated
        subtext1 = "#c1c0c0", -- monokai dimmed1
        text = "#fcfcfa", -- monokai text

        -- Accents. Monokai accent1 is the red family.
        red = "#ff6188", -- monokai accent1
        maroon = "#f27a95", -- shifted accent1
        pink = "#ff8ba7", -- shifted accent1
        flamingo = "#f0c3c0", -- pale accent1
        rosewater = "#f5ddda", -- pale accent1

        peach = "#fc9867", -- monokai accent2
        yellow = "#ffd866", -- monokai accent3
        green = "#a9dc76", -- monokai accent4

        -- Monokai accent5 is a single cyan. Catppuccin needs four cool names.
        -- Each one gets its own value, because integrations use them side by
        -- side. Diffview, for example, uses `blue` for a reference and
        -- `sapphire` elsewhere in the same panel.
        blue = "#78dce8", -- monokai accent5
        sky = "#9ae6f0", -- lighter accent5
        sapphire = "#6bc4d4", -- darker accent5
        teal = "#8ee0d0", -- shifted accent5

        -- Monokai accent6 is a single purple. Same reasoning as the cyans.
        mauve = "#ab9df2", -- monokai accent6
        lavender = "#c0b6f7", -- lighter accent6
      },
    },

    -- DIFF CONTRAST, FOR EVERY PLUGIN
    -- Catppuccin builds its diff backgrounds by blending an accent into
    -- `C.base`. The default amounts assume the Mocha base `#1e1e2e`. The
    -- Monokai base `#2d2a2e` is lighter, so the same amounts give rows that
    -- are almost the background color.
    --
    -- The `blend` table below is the single place that sets diff contrast. It
    -- drives two families of highlight groups:
    --
    -- 1. The CORE groups `DiffAdd`, `DiffDelete`, `DiffChange` and `DiffText`.
    --    Most plugins read these. Diffview copies them into its own groups
    --    (`diffview.nvim/lua/diffview/hl.lua:465-468`). Gitsigns links its
    --    preview groups to them (`groups/integrations/gitsigns.lua:34-35`).
    --    mini.diff links its overlay groups to them
    --    (`groups/integrations/mini.lua:43-46`). Vim diff mode, fugitive and
    --    Octo read them directly.
    -- 2. The `Neogit*` groups. Neogit is the only exception in the whole
    --    plugin: its integration file computes its own colors and never reads
    --    the core groups (`groups/integrations/neogit.lua:38-64`). Without the
    --    entries below, a Neogit added row stays at `#393b36`, while a Diffview
    --    added row is `#48513f`. The two views then disagree. The same `blend`
    --    values are therefore applied to both families.
    --
    -- To change the diff contrast anywhere, change `blend` only.
    --
    -- `highlight_overrides[flavour]` accepts a function. Catppuccin calls it
    -- with the merged palette (`lib/mapper.lua:64`), so these values follow the
    -- `color_overrides` above.
    highlight_overrides = {
      mocha = function(C)
        local U = require "catppuccin.utils.colors"

        -- How much accent to mix into the background. Larger is stronger.
        local blend = {
          row = 0.22, -- a normal added or removed row (core default 0.18, Neogit 0.095)
          row_focus = 0.42, -- a row of the hunk under the cursor (Neogit default 0.345)
          word = 0.66, -- a word-level mark inside a changed row (Neogit default 0.500)
          context = 0.12, -- a changed but unmodified row (core DiffChange default 0.07)
        }

        --- Build a background from an accent and a blend amount.
        ---@param color string hex color from the palette
        ---@param amount number blend amount from the table above
        local function bg(color, amount) return U.darken(color, amount, C.base) end

        return {
          -- 1. Core groups. Every plugin above inherits these.
          DiffAdd = { bg = bg(C.green, blend.row) },
          DiffDelete = { bg = bg(C.red, blend.row), fg = C.overlay0 },
          DiffChange = { bg = bg(C.blue, blend.context) },
          DiffText = { bg = bg(C.blue, blend.word), fg = C.crust, style = { "bold" } },

          -- 2. Neogit groups, with the same amounts.
          NeogitDiffAdd = {
            bg = bg(C.green, blend.row),
            fg = U.darken(C.green, 0.900, C.base),
          },
          NeogitDiffDelete = {
            bg = bg(C.red, blend.row),
            fg = U.darken(C.red, 0.900, C.base),
          },
          NeogitDiffAddHighlight = {
            bg = bg(C.green, blend.row_focus),
            fg = U.lighten(C.green, 0.900, C.text),
          },
          NeogitDiffDeleteHighlight = {
            bg = bg(C.red, blend.row_focus),
            fg = U.lighten(C.red, 0.900, C.text),
          },
          NeogitDiffAddInline = {
            bg = bg(C.green, blend.word),
            fg = C.crust,
            style = { "bold" },
          },
          NeogitDiffDeleteInline = {
            bg = bg(C.red, blend.word),
            fg = C.crust,
            style = { "bold" },
          },
          -- NOTE: `NeogitDiffContextHighlight` needs no entry. Its default is
          -- already `C.surface0` (`groups/integrations/neogit.lua:38-40`), and
          -- the `color_overrides` above give that name its Monokai value.

          -- 3. FLOATS AND POPUPS
          -- Catppuccin puts floats on `C.mantle` (`#221f22`), which is DARKER
          -- than the editor background. Monokai Pro does the opposite: it puts
          -- them on `dimmed5` (`#403e41`), which is LIGHTER
          -- (`monokai-pro/theme/groups/editor.lua:76-99`).
          -- The groups below restore the Monokai direction. They reach every
          -- float, because plugins link to these core groups. Which-key is one
          -- example (`groups/integrations/which_key.lua:7-8`).
          NormalFloat = { bg = C.surface1, fg = C.text },
          -- Monokai draws the border ring in the editor background, so the
          -- lighter float stands away from the text behind it.
          FloatBorder = { bg = C.base, fg = C.overlay2 },
          FloatTitle = { bg = C.base, fg = C.yellow, style = { "bold" } },

          -- The completion menu uses the same surface as a float.
          -- Monokai selects a row with `dimmed3` (`scheme.lua:243`).
          Pmenu = { bg = C.surface1, fg = C.subtext0 },
          PmenuSel = { bg = C.overlay0, style = { "bold" } },
          PmenuSbar = { bg = C.surface0 },
          PmenuThumb = { bg = C.overlay0 },
        }
      end,
    },
  },
}
