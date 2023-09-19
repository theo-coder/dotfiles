return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")

		local dashboard = require("alpha.themes.dashboard")
		local icons = require("utils.icons").ui

		local time = os.date("%H:%M")
		local v = vim.version()
		local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch

		dashboard.section.header.val = {
			" ",
			" ",
			" ",
			" ",
			"       ¿╗@╣╣╫╫╣@@╗µ ",
			"    ,@╣╫╫╫╫╫╫╫╫╫╫╫╫╫@_ ",
			"   ╓╫╫╫╫╣╩╙   └╙╝╣╫╫╫╫µ ",
			"  j╫╫╫╫╙          ╝╫╫╫╫H    j▒µ     _╓╔▒▒▒▒Nµ_      _╓@@╣╫╫╫╫╛     ,¿╓╓µ ",
			'  ╫╫╫╫Ñ            ╫╫╫╫@    )▒▒H  .╔▒▒▒╙""²╚▒▒N_   ╔╣╫╫╝╙╙╙└   .╔@╫╫╫╣╣╛ ',
			'  ╢╫╫╫N   .╗@@µ    ╫╫╫╫╣    j▒▒H  ▒▒▒^      "▒▒▒  j╫╫╬ ,²╓╓╓╓¿,╣╫╫╩└ ',
			"  ²╫╫╫╫µ  ║╫╫╫╫H  #╫╫╫╫H    ²▒▒H  ▒▒▒        ▒▒▒  ║╫╫H ╝╣╫╫╣╩ ║╫╫Ñ ",
			"   ²╫╫╫╫@╗¿╙╝╝▒╓@╣╫╫╫╣╛     ²▒▒H  ▒▒▒      _▒▒▒^  ╫╫╫H        ╫╫╫⌂ ",
			'     ╙╫╫╫╫╫╫╫╫╫╫╫╫╫╣╨       "▒▒H  ▒▒▒▒▒▒▒▒▒▒▒╚    ╫╫╫─        ╫╫╣ ',
			'        ╙╝╝╣╣╣╣╝╝╙            "   ²²²²²²²""       ²└          ²└ ',
			" ",
		}

		dashboard.section.header.opts.hl = "Function"

		dashboard.section.buttons.val = {
			dashboard.button("f", icons.Search .. "  Find File", ":Telescope find_files<CR>"),
			dashboard.button("n", icons.File .. "  New File", ":ene!<CR>"),
			dashboard.button("p", icons.Project .. "  Projects", ":Telescope projects<CR>"),
			dashboard.button("r", icons.History .. "  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("t", icons.Text .. "  Find Text", ":Telescope live_grep<CR>"),
			dashboard.button(
				"c",
				icons.Gear .. "  NVIM Config",
				":edit " .. string.format("%s/.config/nvim", vim.env.HOME) .. "<CR>"
			),
			dashboard.button("q", icons.Close .. "  Quit", ":qa<CR>"),
		}

		dashboard.section.footer.val = {
			" " .. time .. " ",
			version,
		}

		alpha.setup(dashboard.opts)
	end,
}
