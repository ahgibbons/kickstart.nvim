vim.keymap.set('v', '<leader>#', function()
  print 'you pressed <leader>#'
  local vstart = vim.fn.getpos 'v'
  local vend = vim.fn.getpos '.'

  local startline = vstart[2]
  local endline = vend[2]

  if startline > endline then
    startline, endline = endline, startline
  end

  local lines = vim.api.nvim_buf_get_lines(0, startline - 1, endline, false)

  local cs = vim.bo.commentstring
  local prefix = cs:match('^(.-)%%s'):gsub('%s+$', '')

  for i = 1, #lines do
    lines[i] = prefix .. lines[i]
  end

  vim.api.nvim_buf_set_lines(0, startline - 1, endline, false, lines)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end)
