local colorscheme = "material"

local status_ok, m = pcall(require, 'material')
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

local colors = require "material.colors"
local c = colors.main

function SyntaxItem()
  return vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."),vim.fn.col("."),1),"name")
end

m.setup({
    contrast = {
            terminal = true, -- Enable contrast for the built-in terminal
            sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
            floating_windows = true, -- Enable contrast for floating windows
            cursor_line = false, -- Enable darker background for the cursor line
            non_current_windows = true, -- Enable darker background for non-current windows
            filetypes = { "terminal", "packer" }, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { --[[ italic = true ]] },
        strings = { --[[ bold = true ]] },
        keywords = { --[[ underline = true ]] },
        functions = { --[[ bold = true, undercurl = true ]] },
        variables = { },
        operators = {},
        types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "nvim-cmp",
        -- "nvim-navic",
        -- "nvim-tree",
        -- "nvim-web-devicons",
        -- "sneak",
        -- "telescope",
        -- "trouble",
        -- "which-key",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to everride the default colors, set this to a function

    -- Overwrite highlights with your own
    custom_highlights = {
        Identifier = {
            fg = c.white,
        },
        ["@field"] = {
            fg = "#C0C0EE",
        },
    },
})

vim.g.material_style = "darker";

---@diagnostic disable-next-line: redefined-local
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

