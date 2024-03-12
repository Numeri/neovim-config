local session_directory = vim.fn.stdpath('config') .. '/sessions'
if vim.fn.isdirectory(session_directory) == 0 then
  vim.fn.mkdir(session_directory, 'p')
end

-- Set the default session save directory
vim.g.session_directory = session_directory

-- Command to save the session
vim.api.nvim_create_user_command('SaveSession', function()
  vim.cmd('mksession! ' .. vim.g.session_directory .. '/session.vim')
end, {})

-- Command to load the session
vim.api.nvim_create_user_command('LoadSession', function()
  vim.cmd('source ' .. vim.g.session_directory .. '/session.vim')
end, {})

-- Command to save the session with a name
vim.api.nvim_create_user_command('SaveSessionAs', function(opts)
  vim.cmd('mksession! ' .. vim.g.session_directory .. '/' .. opts.args .. '.vim')
end, { nargs = 1 })

-- Command to load the session with a name
vim.api.nvim_create_user_command('LoadSessionAs', function(opts)
  vim.cmd('source ' .. vim.g.session_directory .. '/' .. opts.args .. '.vim')
end, { nargs = 1 })
