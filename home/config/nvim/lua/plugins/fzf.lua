return {
		'ibhagwan/fzf-lua',
		config = function()
            local fzf = require('fzf-lua')

			-- stop putting a giant window over my editor
			fzf.setup{
				winopts = {
					split = "belowright 10new",
					preview = {
						hidden = true,
					}
				},
				files = {
					-- file icons are distracting
					file_icons = false,
					-- git icons are nice
					git_icons = true,
					-- but don't mess up my anchored search
					_fzf_nth_devicons = true,
				},
				buffers = {
					file_icons = false,
					git_icons = true,
					-- no nth_devicons as we'll do that
					-- manually since we also use
					-- with-nth
				},
				fzf_opts = {
					-- no reverse view
					["--layout"] = "default",
				},
			}
			-- when using C-p for quick file open, pass the file list through
			--
			--   https://github.com/jonhoo/proximity-sort
			--
			-- to prefer files closer to the current file.
			vim.keymap.set('', '<leader>pf', function()
				opts = {}
				opts.cmd = 'fd --color=never --hidden --type f --type l --exclude .git --exclude .next --exclude target --exclude node_modules --exclude .sqlx'
				local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
				if base ~= '.' then
					-- if there is no current file,
					-- proximity-sort can't do its thing
					opts.cmd = opts.cmd .. (" | proximity-sort %s"):format(vim.fn.shellescape(vim.fn.expand('%')))
				end
				opts.fzf_opts = {
				  ['--scheme']    = 'path',
				  ['--tiebreak']  = 'index',
				  ["--layout"]    = "default",
				}
				fzf.files(opts)
			end)
			-- use fzf to search buffers as well
			vim.keymap.set('n', '<leader>;', function()
				fzf.buffers({
					-- just include the paths in the fzf bits, and nothing else
					-- https://github.com/ibhagwan/fzf-lua/issues/2230#issuecomment-3164258823
					fzf_opts = {
					  ["--with-nth"]      = "{-3..-2}",
					  ["--nth"]           = "-1",
					  ["--delimiter"]     = "[:\u{2002}]",
					  ["--header-lines"]  = "false",
					},
					header = false,
				})
			end)

            vim.keymap.set('n', '<leader>pg', fzf.git_files)
        
            vim.keymap.set('n', '<leader>sg', fzf.live_grep)
            vim.keymap.set('n', '<leader>sw', fzf.grep_cword) 
                
            vim.keymap.set('n', '<leader>sh', fzf.help_tags)
		end
	}