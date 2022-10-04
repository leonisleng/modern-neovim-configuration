local utils = require("utils")
local ls = utils.fn.require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = utils.fn.require("luasnip.util.events")
local ai = utils.fn.require("luasnip.nodes.absolute_indexer")
local fmt = utils.fn.require("luasnip.extras.fmt").fmt
local m = utils.fn.require("luasnip.extras").m
local lambda = utils.fn.require("luasnip.extras").l
local postfix = utils.fn.require("luasnip.extras.postfix").postfix

local M = {
	s("ureq", {
		t({ [[utils.fn.require("]] }),
		i(1),
		t({ [[")]] }),
	}),
	s("utils", {
		t({ [[local utils = require("utils")]] }),
	}),
	s("package", {
		t({
			'package.path = debug.getinfo(1, "S").source:match([[^@?(.*[\\/])[^\\/]-$]])'
				.. [[.. "?.lua;" .. package.path]],
		}),
	}),
	s("tasks", {
		t({
			[[local utils = require("utils")]],
			"",
			[[local overseer = utils.fn.require("overseer")]],
			"",
			[[local scriptPath = utils.fn.root_pattern() .. "/.nvim/task/task.sh"]],
			"",
			[[overseer.register_template({]],
			[[	name = "template",]],
			[[	builder = function()]],
			[[		return {]],
			[[			cmd = { scriptPath },]],
			[[			args = { "template" },]],
			[[		}]],
			[[	end,]],
			[[})]],
		}),
	}),
	s("task", {
		t({
			[[overseer.register_template({]],
			[[	name = "]],
		}),
		i(1, "name"),
		t({
			[[",]],
			[[	builder = function()]],
			[[		return {]],
			[[			cmd = { scriptPath },]],
			[[			args = { "]],
		}),
		i(2, "args"),
		t({
			[[" },]],
			[[		}]],
			[[	end,]],
			[[})]],
		}),
	}),
}

return M
