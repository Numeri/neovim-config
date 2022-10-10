local colorscheme = "material"

local status_ok, m = pcall(require, 'material')
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

m.setup({

	contrast = {
		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = true, -- Enable contrast for floating windows
		line_numbers = true, -- Enable contrast background for line numbers
		sign_column = true, -- Enable contrast background the sign column
		cursor_line = true, -- Enable darker background for the cursor line
		non_current_windows = true, -- Enable darker background for non-current windows
		popup_menu = true, -- Enable lighter background for the popup menu
	},

	italics = {
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf" -- Darker qf list background
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},

	disable = {
		borders = false, -- Disable borders between verticaly split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	custom_highlights = {} -- Overwrite highlights with your own
})

vim.g.material_style = "darker";

---@diagnostic disable-next-line: redefined-local
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
