local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>f", ":Lex 20<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Switch between buffers
keymap("n", "<leader>b", ":ls<CR>:b<Space>", opts)

-- Clear highlighting
keymap("n", "<leader>c", ":noh<CR>", opts)

-- Jump straight to mark
keymap("n", "<leader>'", "`", opts)

-- Autocomplete across buffers
local function complete_with_k()
  vim.opt.complete:append("k")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
  -- Remove 'k' from 'complete' option after a short delay to ensure it's removed after the completion is done
  vim.defer_fn(function()
    vim.opt.complete:remove("k")
  end, 0)
end

keymap('i', '<C-b>', '', { noremap = true, callback = complete_with_k })


function ModifyQuickFixList()
    if vim.opt.modifiable then
        vim.cmd "cgetbuffer"
    else
        vim.opt_local.errorformat = "%f|%l col %c|%m"
        vim.cmd "set modifiable"
    end
end

keymap("n", "mm", "call v:lua.ModifyQuickFixList()<CR>", opts)

function ReplacePairs(line)
  local pairs = {
    {"new", "old"},
    {"src", "tgt"},
    {"source", "target"},
    {"input", "output"}
  }

  local old_line = line
  for _, pair in ipairs(pairs) do
    local pattern = pair[1]
    local replacement = pair[2]
    line = line:gsub(pattern, replacement)
    if line == old_line then
        line = line:gsub(replacement, pattern)
    end
  end

  return line
end

keymap('n', '<leader>z', ':lua vim.fn.setline(".", ReplacePairs(vim.fn.getline(".")))<CR>', { noremap = true, silent = true })
keymap('v', '<leader>z', ':lua for _, line in ipairs(vim.fn.getline("\'<", "\'>")) do vim.fn.setline(".", ReplacePairs(line)) vim.cmd("normal j") end<CR>', { noremap = true, silent = true })

function ScrollToRandomLine()
    local total_lines = vim.fn.line('$')
    local rand_line = math.random(1, total_lines)
    vim.cmd('normal! ' .. rand_line .. 'Gzz')
end

keymap('n', '<leader>s', ':lua ScrollToRandomLine()<CR>', { noremap = true, silent = true })

function BidirectionalLeap()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window }, inclusive_op = true }
end

vim.keymap.set({'n', 'v', 'x', 'o'}, 's', BidirectionalLeap)

-- Opens the current file (and selected lines, if in visual mode)
-- in GitHub, at the current branch.
function OpenInGitHub()
  -- Get the remote URL from git.
  local remote = vim.fn.systemlist('git remote get-url origin')[1]
  if not remote or remote == '' then
    print('No remote found')
    return
  end

  -- Convert SSH URL to HTTPS.
  -- Replaces "git@github.com:" with "https://github.com/"
  remote = remote:gsub("git@([^:]+):", "https://%1/")
           :gsub('%.git$', '')  -- Remove trailing ".git"

  -- Get the current branch.
  local branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]
  if not branch or branch == '' then
    print('No branch found')
    return
  end

  -- Get the absolute path of the current file.
  local file = vim.fn.expand('%:p')

  -- Get the Git repository's top-level directory.
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root and git_root ~= '' then
    -- Make file path relative to the Git root.
    file = file:gsub('^' .. git_root .. '/', '')
  else
    print('Not in a Git repository?')
    return
  end

  -- Build the basic GitHub URL.
  local url = remote .. '/blob/' .. branch .. '/' .. file

  -- Depending on mode, add a line fragment.
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\022' then  -- \022 is CTRL-V block mode.
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    url = url .. '#L' .. start_line .. '-L' .. end_line
  else
    local line = vim.fn.line('.')
    url = url .. '#L' .. line
  end

  -- Display the URL for debugging.
  print("Opening " .. url)

  -- Use vim.fn.jobstart to open the URL asynchronously.
  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

keymap('n', '<leader>w', ':lua OpenInGitHub()<CR>', { noremap = true, silent = true })
keymap('v', '<leader>w', ':lua OpenInGitHub()<CR>', { noremap = true, silent = true })
keymap('x', '<leader>w', ':lua OpenInGitHub()<CR>', { noremap = true, silent = true })

-- Insert --
keymap('i', 'öl', 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
keymap('i', 'ök', '<Plug>(copilot-previous)', opts)
keymap('i', 'öj', '<Plug>(copilot-next)', opts)
keymap('i', 'öö', '<Plug>(copilot-suggest)', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

