local utils = require("utils")

require("close_buffers").setup()

vim.keymap.set("n", "<C-x>", ":BDelete this<CR>", { silent = true })
