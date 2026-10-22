-- Start screen (snacks.nvim dashboard) and statusline (lualine).
-- Both keep transparent backgrounds on vira and the -glass themes.

-- Swap this out for any ASCII art you like (e.g. from patorjk.com/software/taag)
local header = [[
⣿⣿⣿⣿⣿⣷⣿⣿⣿⡅⡹⢿⠆⠙⠋⠉⠻⠿⣿⣿⣿⣿⣿⣿⣮⠻⣦⡙⢷⡑⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⠡⠌⠂⣙⠻⣛⠻⠷⠐⠈⠛⢱⣮⣷⣽⣿
⣿⣿⣿⣿⡇⢿⢹⣿⣶⠐⠁⠀⣀⣠⣤⠄⠀⠀⠈⠙⠻⣿⣿⣿⣦⣵⣌⠻⣷⢝⠦⠚⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣻⣿⣊⡃⠀⣙⠿⣿⣿⣿⣎⢮⡀⢮⣽⣿⣿
⢿⣿⣿⣿⣧⡸⡎⡛⡩⠖⠀⣴⣿⣿⣿⠀⠀⠀⠀⠸⠇⠀⠙⢿⣿⣿⣿⣷⣌⢷⣑⢷⣄⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣫⠶⠛⠉⠀⠁⠀⠈⠈⠀⠠⠜⠻⣿⣆⢿⣼⣿⣿⣿
⢐⣿⣿⣿⣿⣧⢧⣧⢻⣦⢀⣹⣿⣿⣿⣇⠀⠄⠀⠀⠀⡀⠀⠈⢻⣿⣿⣿⣿⣷⣝⢦⡹⠷⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿⠈⠁⠀⠀⠀⠁⠀⠀⠀⠱⣶⣄⡀⠀⠈⠛⠜⣿⣿⣿⣿
⠀⠊⢫⣿⣏⣿⡌⣼⣄⢫⡌⣿⣿⣿⣿⣿⣦⡈⠲⣄⣤⣤⡡⢀⣠⣿⣿⣿⣿⣿⣿⣷⣼⣍⢬⣦⡙⣿⣿⣿⣿⣿⣯⢁⡄⠀⡀⡀⠀⠄⢈⣠⢪⠀⣿⣿⣿⣦⠀⢉⢂⠹⡿⣿⣿
⠀⠀⠄⢹⢃⢻⣟⠙⣿⣦⠱⢻⣿⣿⣿⣿⣿⣿⣷⣬⣍⣭⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡙⢿⣼⡿⣿⣿⣿⣿⣿⣷⣄⠘⣱⢦⣤⡴⡿⢈⣼⣿⣿⣿⣇⣴⣶⣮⣅⢻⣿⡏
⠀⠀⠈⠹⣇⢡⢿⡆⠻⣿⣷⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣍⡻⣿⣟⣻⣿⣿⣿⣿⣷⣦⣥⣬⣤⣴⣾⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⡜⠃
⠀⠀⠀⢀⣘⠈⢂⠃⣧⡹⣿⣷⡄⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣅⡙⢿⣟⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⡕⠂
⠀⠀⠀⠀⠀⠀⠛⢷⣜⢷⡌⠻⣿⣿⣦⣝⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣹⣷⣦⣹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠉⠃⠀]]

-- Close listed buffers on one side of the current one (by buffer number)
local function close_side(side)
	local cur = vim.api.nvim_get_current_buf()
	for _, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if (side == "left" and info.bufnr < cur) or (side == "right" and info.bufnr > cur) then
			Snacks.bufdelete(info.bufnr)
		end
	end
end

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>h",
				function()
					Snacks.dashboard()
				end,
				desc = "Home screen",
			},
			-- Buffers
			{
				"<leader>c",
				function()
					Snacks.bufdelete()
				end,
				desc = "Close buffer",
			},
			{
				"<leader>C",
				function()
					Snacks.bufdelete({ force = true })
				end,
				desc = "Force close buffer",
			},
			{
				"<leader>bc",
				function()
					Snacks.bufdelete.other()
				end,
				desc = "Close all buffers except current",
			},
			{
				"<leader>bC",
				function()
					Snacks.bufdelete.all()
				end,
				desc = "Close all buffers",
			},
			{
				"<leader>bl",
				function()
					close_side("left")
				end,
				desc = "Close all buffers to the left",
			},
			{
				"<leader>br",
				function()
					close_side("right")
				end,
				desc = "Close all buffers to the right",
			},
			{
				"<leader>R",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename current file",
			},
			-- Git
			{
				"<leader>go",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git browse (open)",
				mode = { "n", "x" },
			},
			-- Terminal
			{
				"<leader>tf",
				function()
					Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } })
				end,
				desc = "Floating terminal",
			},
			{
				"<leader>th",
				function()
					Snacks.terminal.toggle(nil, { win = { position = "bottom" } })
				end,
				desc = "Horizontal terminal",
			},
			{
				"<leader>tv",
				function()
					Snacks.terminal.toggle(nil, { win = { position = "right" } })
				end,
				desc = "Vertical terminal",
			},
			{
				"<leader>tl",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>tn",
				function()
					Snacks.terminal.toggle("node", { win = { position = "float", border = "rounded" } })
				end,
				desc = "Node REPL",
			},
			{
				"<leader>tp",
				function()
					Snacks.terminal.toggle("python3", { win = { position = "float", border = "rounded" } })
				end,
				desc = "Python REPL",
			},
			{
				"<F7>",
				function()
					Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } })
				end,
				desc = "Toggle terminal",
				mode = { "n", "t" },
			},
			{
				"<C-'>",
				function()
					Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } })
				end,
				desc = "Toggle terminal",
				mode = { "n", "t" },
			},
		},
		init = function()
			-- <leader>u UI toggles (like AstroNvim)
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					local toggle = Snacks.toggle
					local function flag(scope, name, label)
						return toggle.new({
							name = label,
							get = function()
								return vim[scope][name] ~= false
							end,
							set = function(state)
								vim[scope][name] = state
							end,
						})
					end
					flag("b", "autoformat", "Autoformat (buffer)"):map("<leader>uf")
					flag("g", "autoformat", "Autoformat (global)"):map("<leader>uF")
					flag("b", "completion", "Autocompletion (buffer)"):map("<leader>uc")
					flag("g", "completion", "Autocompletion (global)"):map("<leader>uC")
					toggle
						.new({
							name = "Autopairs",
							get = function()
								return not require("nvim-autopairs").state.disabled
							end,
							set = function(state)
								local ap = require("nvim-autopairs")
								if state then
									ap.enable()
								else
									ap.disable()
								end
							end,
						})
						:map("<leader>ua")
					toggle.diagnostics():map("<leader>ud")
					toggle
						.new({
							name = "Diagnostic virtual text",
							get = function()
								return vim.diagnostic.config().virtual_text ~= false
							end,
							set = function(state)
								vim.diagnostic.config({
									virtual_text = state and { spacing = 2, prefix = "●" } or false,
								})
							end,
						})
						:map("<leader>uv")
					toggle
						.new({
							name = "Diagnostic virtual lines",
							get = function()
								return vim.diagnostic.config().virtual_lines and true or false
							end,
							set = function(state)
								vim.diagnostic.config({ virtual_lines = state })
							end,
						})
						:map("<leader>uV")
					toggle
						.new({
							name = "Inlay hints (buffer)",
							get = function()
								return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
							end,
							set = function(state)
								vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
							end,
						})
						:map("<leader>uh")
					toggle
						.new({
							name = "Inlay hints (global)",
							get = function()
								return vim.lsp.inlay_hint.is_enabled()
							end,
							set = function(state)
								vim.lsp.inlay_hint.enable(state)
							end,
						})
						:map("<leader>uH")
					toggle.option("signcolumn", { off = "no", on = "yes", name = "Signcolumn" }):map("<leader>ug")
					toggle.option("foldcolumn", { off = "0", on = "1", name = "Foldcolumn" }):map("<leader>u>")
					toggle.option("laststatus", { off = 0, on = 3, name = "Statusline" }):map("<leader>ul")
					toggle.option("showtabline", { off = 0, on = 2, name = "Tabline" }):map("<leader>ut")
					toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal" }):map("<leader>uS")
					toggle.option("spell", { name = "Spellcheck" }):map("<leader>us")
					toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					toggle.line_number():map("<leader>un")
					toggle.treesitter():map("<leader>uy")
					toggle.zen():map("<leader>uZ")
					toggle
						.new({
							name = "Color highlighting",
							get = function()
								return vim.lsp.document_color.is_enabled()
							end,
							set = function(state)
								vim.lsp.document_color.enable(state)
							end,
						})
						:map("<leader>uz")
				end,
			})
		end,
		opts = {
			dashboard = {
				enabled = true,
				width = 56,
				preset = {
					header = header,
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = " ",
							key = "S",
							desc = "Last Session (any directory)",
							action = function() require("persistence").load({ last = true }) end,
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "e", desc = "File Tree", action = ":NvimTreeOpen" },
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })",
						},
						{ icon = " ", key = "l", desc = "Plugins", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header", padding = 2 },
					{ section = "keys", gap = 0, padding = 2 },
					{
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						cwd = false,
						limit = 5,
						indent = 2,
						padding = 1,
					},
					{ icon = " ", title = "Projects", section = "projects", limit = 5, indent = 2, padding = 2 },
					{ section = "startup" },
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			vim.o.showmode = false -- the statusline shows the mode
			vim.o.laststatus = 3
		end,
		config = function()
			-- Transparent theme: coloured text, no background blocks
			local function transparent_theme(c)
				local function mode(color)
					return {
						a = { fg = color, bg = "NONE", gui = "bold" },
						b = { fg = c.fg, bg = "NONE" },
						c = { fg = c.dim, bg = "NONE" },
					}
				end
				return {
					normal = mode(c.blue),
					insert = mode(c.green),
					visual = mode(c.magenta),
					replace = mode(c.red),
					command = mode(c.yellow),
					terminal = mode(c.cyan),
					inactive = mode(c.comment),
				}
			end

			local function lsp_clients()
				local names = vim.tbl_map(function(client)
					return client.name
				end, vim.lsp.get_clients({ bufnr = 0 }))
				return #names > 0 and (" " .. table.concat(names, ", ")) or ""
			end

			-- Transparent themes (vira, -glass) get coloured text on no background;
			-- any other theme uses lualine's "auto"
			local function setup()
				local vira = require("config.theme").is_transparent()
				local c = require("config.theme").colors()
				local function fg(color)
					return vira and { fg = color } or nil
				end
				require("lualine").setup({
					options = {
						theme = vira and transparent_theme(c) or "auto",
						globalstatus = true,
						component_separators = "",
						section_separators = "",
						disabled_filetypes = { statusline = { "snacks_dashboard" } },
					},
					sections = {
						lualine_a = { { "mode", icon = "" } },
						lualine_b = {
							{ "branch", icon = "", color = fg(c.magenta) },
							{
								"diff",
								symbols = { added = " ", modified = " ", removed = " " },
								diff_color = vira and {
									added = { fg = c.green },
									modified = { fg = c.yellow },
									removed = { fg = c.red },
								} or nil,
							},
						},
						lualine_c = {
							{ "filetype", icon_only = true, padding = { left = 1, right = 0 } },
							{
								"filename",
								path = 1,
								color = fg(c.fg),
								symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]", newfile = " " },
							},
							{
								"diagnostics",
								symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
							},
						},
						lualine_x = {
							{ lsp_clients, color = fg(c.cyan) },
							{ "encoding", color = fg(c.comment) },
							{ "fileformat", color = fg(c.comment) },
						},
						lualine_y = { { "progress", color = fg(c.dim) } },
						lualine_z = { { "location", icon = "", color = fg(c.accent) } },
					},
					extensions = { "nvim-tree", "lazy", "mason" },
				})
			end

			setup()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("LualineTheme", { clear = true }),
				callback = setup,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			-- AstroNvim buffer navigation (follows tabline order)
			{ "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
			{ ">b", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer tab right" },
			{ "<b", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer tab left" },
			{ "<leader>bse", "<cmd>BufferLineSortByExtension<CR>", desc = "Sort by extension" },
			{ "<leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative path" },
			{ "<leader>bsp", "<cmd>BufferLineSortByDirectory<CR>", desc = "Sort by full path" },
			{
				"<leader>bsi",
				function()
					require("bufferline").sort_by(function(a, b)
						return a.id < b.id
					end)
				end,
				desc = "Sort by buffer number",
			},
		},
		config = function()
			require("bufferline").setup({
				options = {
					close_command = function(buf)
						Snacks.bufdelete(buf)
					end,
					right_mouse_command = function(buf)
						Snacks.bufdelete(buf)
					end,
					diagnostics = "nvim_lsp",
					separator_style = "thin",
					indicator = { style = "underline" },
					show_buffer_close_icons = false,
					offsets = {
						{ filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true },
					},
				},
				-- Transparent: strip every background, keep coloured text
				-- Re-evaluated on every colorscheme change; only transparent themes get these
				highlights = function(defaults)
					if not require("config.theme").is_transparent() then
						return {}
					end
					local c = require("config.theme").colors()
					local hl = {}
					for name, spec in pairs(defaults.highlights) do
						hl[name] = vim.tbl_extend("force", spec, { bg = "NONE" })
					end
					for name, spec in pairs(hl) do
						if name:match("_selected$") then
							spec.fg = name:match("^buffer") and c.fg or spec.fg
							spec.bold = true
							spec.italic = false
							spec.sp = c.accent
						elseif name:match("^buffer") or name == "background" then
							spec.fg = c.comment
						end
					end
					hl.separator = { fg = c.gray, bg = "NONE" }
					hl.separator_visible = { fg = c.gray, bg = "NONE" }
					hl.separator_selected = { fg = c.gray, bg = "NONE" }
					hl.offset_separator = { fg = c.gray, bg = "NONE" }
					hl.indicator_selected = { fg = c.accent, bg = "NONE", sp = c.accent }
					return hl
				end,
			})
		end,
	},
}
