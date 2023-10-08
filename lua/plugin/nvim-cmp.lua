local config = function()
	local cmp = require("cmp")

	cmp.setup({
		formatting = {
			format = require("lspkind").cmp_format({
				mode = "symbol_text",
				symbol_map = {
					Text = "󰉿",
					String = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[Lsp]",
					luasnip = "[LuaSnip]",
					rg = "[Rg]",
					treesitter = "[Treesitter]",
					async_path = "[Path]",
					crates = "[Crates]",
				},
			}),
		},
		enabled = function()
			return vim.api.nvim_get_option_value("buftype", {
				buf = 0,
			}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end,
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp", group_index = 1 },
			{ name = "luasnip", group_index = 1 },
			{ name = "buffer", group_index = 2 },
			{ name = "rg", option = { additional_arguments = "--hidden --smart-case" }, group_index = 2 },
			{ name = "treesitter" },
			{ name = "async_path", group_index = 3 },
			{ name = "crates", group_index = 4 },
		}),
		preselect = cmp.PreselectMode.None,
	})

	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
		},
	})

	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
			{ name = "cmdline_history" },
		},
	})

	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "async_path" },
		}, {
			{ name = "cmdline" },
			{ name = "cmdline_history" },
		}),
	})

	-- keymap
	cmp.setup({
		mapping = {
			["<C-k>"] = cmp.mapping(
				cmp.mapping.select_prev_item({
					behavior = cmp.SelectBehavior.Insert,
				}),
				{ "i", "c" }
			),
			["<C-j>"] = cmp.mapping(
				cmp.mapping.select_next_item({
					behavior = cmp.SelectBehavior.Insert,
				}),
				{ "i", "c" }
			),
			["<CR>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Insert,
			}),
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		},
	})
end

return {
	config = config,
}
