vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
}

require('render-markdown').setup {}

-- Print the preview URL so you can open it in a Windows browser if auto-open fails
vim.g.mkdp_echo_preview_url = 1
