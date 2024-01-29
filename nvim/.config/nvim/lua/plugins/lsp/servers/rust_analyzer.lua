return function()
	require("lspconfig").rust_analyzer.setup({
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					features = "all",
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
			},
		},
	})
end
