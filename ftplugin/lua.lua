vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'Execute the current file' })
vim.keymap.set('n', '<leader>X', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
