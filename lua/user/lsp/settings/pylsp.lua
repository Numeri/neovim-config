return {
	settings = {
        pylsp =  {
            plugins = {
                flake8 = {
                    enabled = true,
                    maxLineLength = 140,
                    -- ignore = {'E121', 'E125'},
                },
                rope = { enabled = true },
                pylsp_rope = { enabled = true },
                black = { enabled = true },
                pylsp_mypy = { enabled = false, live_mode = true },
                mypy = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
            },
        },
    },
}
