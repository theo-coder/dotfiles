return {
	"ahmedkhalf/project.nvim",
	event = "VimEnter",
	cmd = "Telescope projects",
	config = function()
		require("project_nvim").setup({})
	end,
}
