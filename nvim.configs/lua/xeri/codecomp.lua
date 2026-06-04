require("codecompanion").setup({
	prompt_library = {
		markdown = {
			dirs = {
				vim.fs.normalize(vim.fn.expand('<sfile>:p:h') .. "/../prompts")
			},
		},
		["Docusaurus"] = {
			interaction = "chat",
			description = "Write documentation for me",
			prompts = {
				{
					role = "user",
					content = [[Just some prompt that will write docs for me.]],
				},
			},
		},
	},
	interactions = {
		chat = {
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot",
		},
		cmd = {
			adapter = "copilot",
		}
	},
})
