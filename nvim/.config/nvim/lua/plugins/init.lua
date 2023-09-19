local plugins = {
	{ "nacro90/numb.nvim", event = "BufReadPre", config = true },
}

table.insert(plugins, require("plugins.lazy"))
table.insert(plugins, require("plugins.nightfox"))
table.insert(plugins, require("plugins.alpha"))
table.insert(plugins, require("plugins.cmp"))
table.insert(plugins, require("plugins.lsp"))
table.insert(plugins, require("plugins.treesitter"))
table.insert(plugins, require("plugins.telescope"))
table.insert(plugins, require("plugins.autopairs"))
table.insert(plugins, require("plugins.gitsigns"))
table.insert(plugins, require("plugins.which-key"))
table.insert(plugins, require("plugins.comment"))
table.insert(plugins, require("plugins.project"))
table.insert(plugins, require("plugins.colorizer"))
table.insert(plugins, require("plugins.statusline"))

return plugins
