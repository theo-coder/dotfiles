return {
	"numToStr/Comment.nvim",
	event = "User FileOpened",
	keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
	config = function()
		local status_ok, comment = pcall(require, "Comment")
		if not status_ok then
			return
		end

		comment.setup({
			active = true,
			on_config_done = nil,
			padding = true,
			sticky = true,
			ignore = "^$",
			mappings = {
				basic = true,
				extra = true,
			},
			toggler = {
				line = "gcc",
				block = "bgc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			pre_hook = function(...)
				local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
				if loaded and ts_comment then
					return ts_comment.create_pre_hook()(...)
				end
			end,
			post_hook = nil,
		})
	end,
}
