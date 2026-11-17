vim.pack.add { 'https://github.com/olimorris/codecompanion.nvim' }

local function ollama_url()
  local ip = vim.trim(vim.fn.system "ip route show default | awk '{print $3}'")
  return ip ~= '' and ('http://' .. ip .. ':11434') or 'http://127.0.0.1:11434'
end

require('codecompanion').setup {
  strategies = {
    chat = { adapter = 'ollama' },
    inline = { adapter = 'ollama' },
  },
  adapters = {
    http = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          env = { url = ollama_url() },
          schema = {
            model = { default = 'qwen2.5-coder:14b' },
            num_ctx = { default = 8192 },
            keep_alive = { default = '30m' },
            temperature = { default = 0.2 },
          },
        })
      end,
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[C]odeCompanion [C]hat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>CodeCompanionActions<cr>', { desc = '[C]odeCompanion [A]ctions' })
vim.keymap.set({ 'n', 'v' }, 'ga', '<cmd>CodeCompanion<cr>', { desc = 'Inline AI prompt' })
