return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"folke/which-key.nvim",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for default `toggle()` implementation.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "snacks",
				},
			}

			-- Required for `opts.auto_reload`.
			vim.o.autoread = true

			local opts = function(desc)
				return { desc = desc, silent = true, noremap = true }
			end

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-S-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>oc", function()
				require("opencode").toggle()
			end, opts("Toggle opencode"))
			vim.keymap.set({ "n", "x" }, "<leader>ox", function()
				require("opencode").select()
			end, opts("Execute opencode action…"))
			vim.keymap.set({ "n", "x" }, "ga", function()
				require("opencode").prompt("@this")
			end, opts("Add to opencode"))
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("messages_half_page_up")
			end, opts("opencode half page up"))
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("messages_half_page_down")
			end, opts("opencode half page down"))

			local start_opencode_server = function()
				local root = vim.fn.getcwd()
				local ocdir = root .. "/.opencode"
				local stat = vim.uv.fs_stat(ocdir)
				if not (stat and stat.type == "directory") then
					return false
				end
				local host = root .. "/.opencodehost"
				-- If already listening, just export and continue
				local servers = table.concat(vim.fn.serverlist(), ",")
				if servers:find(vim.pesc(host), 1, true) then
					vim.env.NVIM = host
					vim.env.NVIM_LISTEN_ADDRESS = host
					return true
				end
				local ok, err = pcall(vim.fn.serverstart, host)
				if ok then
					vim.env.NVIM = host
					vim.env.NVIM_LISTEN_ADDRESS = host
					return true
				else
					-- If a stale socket exists, notify the user
					if vim.uv.fs_stat(host) then
						vim.notify(
							"Opencode: stale host file at " .. host .. ". Remove it if the server isn’t running.",
							vim.log.levels.WARN
						)
					end
					vim.notify("Opencode: server start failed: " .. tostring(err), vim.log.levels.WARN)
					return false
				end
			end
			--- Check if a file or directory exists in this path
			local directory_exists = function(file)
				local ok, err, code = os.rename(file, file)
				if not ok then
					if code == 13 then
						-- Permission denied, but it exists
						return true
					end
				end
				return ok, err
			end
			local ocproject = directory_exists(vim.fn.getcwd() .. "/.opencode")
			if ocproject then
				start_opencode_server()
				vim.notify("Opencode project found, starting server", vim.log.levels.INFO)
			end
		end,
	},
}
