local core = require("niuiic-core")
local filetypes = { "vue", "typescriptreact", "javascriptreact" }

if core.file.file_contains(core.file.root_path() .. "/package.json", "vue") then
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
end

local function search_ts_server_path()
	local local_ts_server_path = core.file.root_path() .. "/node_modules/typescript/lib"
	if core.file.file_or_dir_exists(local_ts_server_path .. "/lib.d.ts") then
		return local_ts_server_path
	else
		return os.getenv("HOME") .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"
	end
end

local function copy_file_path()
	local name = vim.api.nvim_buf_get_name(0)
	local root_path = core.file.root_path()
	local index = string.find(name, root_path, 1, true)
	if index == nil then
		vim.notify("The file is not under the project", vim.log.levels.ERROR)
	else
		local str = string.sub(name, string.len(root_path) + 2)
		str = string.gsub(str, "^(src)", "@", 1)
		if string.find(str, "^[%s%S]*.vue$") == nil then
			str = string.gsub(str, "(.[^.]*)$", "")
		end
		vim.fn.setreg("+", str)
		vim.notify("Copied " .. str .. " to clipboard", vim.log.levels.INFO)
	end
end

local function organize_imports()
	vim.lsp.buf.code_action({
		apply = true,
		filter = function(action)
			return action.title == "Add all missing imports"
		end,
	})
end

local M = {
	filetypes = filetypes,
	root_dir = core.file.root_path,
	init_options = {
		typescript = {
			tsdk = search_ts_server_path(),
		},
	},
	commands = {
		VolarRename = {
			function()
				vim.lsp.buf.rename(nil, {
					name = "volar",
				})
			end,
			description = "Rename",
		},
		VolarFilePath = {
			copy_file_path,
			description = "File Path",
		},
		VolarOrganizeImports = {
			organize_imports,
			description = "File Path",
		},
	},
}

return M
