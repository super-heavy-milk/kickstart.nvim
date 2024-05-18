vim.keymap.set('n', '<leader>x', '<cmd>python3 %<CR>', { desc = 'Execute the current file' })
vim.keymap.set(
    { 'n', 'v' },
    '<leader>X',
    '<cmd>.python3<CR>',
    { desc = 'Execute the current line(s)' }
)
