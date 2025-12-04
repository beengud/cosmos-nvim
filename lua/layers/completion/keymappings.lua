-- Completion layer keymappings
-- Includes: nvim-cmp, avante.nvim, amp.nvim, codecompanion

local cosmos = require('core.cosmos')

-- ============================================================================
-- AVANTE.NVIM KEYMAPPINGS
-- ============================================================================

-- Toggle Avante sidebar
cosmos.add_leader_keymapping('n|ae', {
  '<cmd>AvanteToggle<cr>',
  name = 'Toggle Avante',
})

-- Ask about current code
cosmos.add_leader_keymapping('n|aa', {
  '<cmd>AvanteAsk<cr>',
  name = 'Ask Avante',
})

-- Edit selected code with Avante
cosmos.add_leader_keymapping('v|ae', {
  '<cmd>AvanteEdit<cr>',
  name = 'Edit with Avante',
})

-- Focus on Avante sidebar
cosmos.add_leader_keymapping('n|af', {
  '<cmd>AvanteRefocus<cr>',
  name = 'Focus Avante',
})

-- ============================================================================
-- AMP.NVIM KEYMAPPINGS
-- ============================================================================

-- Quick message to Amp (requires: amp --ide running)
cosmos.add_leader_keymapping('n|aam', {
  function()
    local message = vim.fn.input('Message to Amp: ')
    if message ~= '' then
      local ok, amp_message = pcall(require, 'amp.message')
      if ok then
        amp_message.send_message(message)
        print('→ Sent to Amp')
      else
        print('Error: amp.nvim not loaded')
      end
    end
  end,
  name = 'Message to Amp',
})

-- Send current file context to Amp
cosmos.add_leader_keymapping('n|aac', {
  function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == '' then
      print('Current buffer has no filename')
      return
    end

    local relative_path = vim.fn.fnamemodify(bufname, ':.')
    local ok, amp_message = pcall(require, 'amp.message')
    if ok then
      amp_message.send_to_prompt('@' .. relative_path)
      print('→ File context sent to Amp')
    else
      print('Error: amp.nvim not loaded')
    end
  end,
  name = 'File context to Amp',
})

-- Send selection to Amp prompt
cosmos.add_leader_keymapping('v|aas', {
  function()
    local start_line = vim.fn.line("'<") - 1
    local end_line = vim.fn.line("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    local text = table.concat(lines, '\n')

    local ok, amp_message = pcall(require, 'amp.message')
    if ok then
      amp_message.send_to_prompt(text)
      print('→ Selection sent to Amp')
    else
      print('Error: amp.nvim not loaded')
    end
  end,
  name = 'Selection to Amp',
})

-- Add file reference with line numbers to Amp prompt
cosmos.add_leader_keymapping('v|aar', {
  function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == '' then
      print('Current buffer has no filename')
      return
    end

    local relative_path = vim.fn.fnamemodify(bufname, ':.')
    local ref = '@' .. relative_path
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    if start_line ~= end_line then
      ref = ref .. '#L' .. start_line .. '-' .. end_line
    else
      ref = ref .. '#L' .. start_line
    end

    local ok, amp_message = pcall(require, 'amp.message')
    if ok then
      amp_message.send_to_prompt(ref)
      print('→ File reference sent to Amp')
    else
      print('Error: amp.nvim not loaded')
    end
  end,
  name = 'File reference to Amp',
})

-- Amp health check
cosmos.add_leader_keymapping('n|aah', {
  '<cmd>checkhealth amp<cr>',
  name = 'Amp health check',
})

-- View Amp logs
cosmos.add_leader_keymapping('n|aal', {
  function()
    local log_path = vim.fn.expand('~/.cache/nvim/amp.log')
    if vim.fn.filereadable(log_path) == 0 then
      print('Amp log not found: ' .. log_path)
      return
    end
    vim.cmd('tabnew')
    vim.cmd('read ' .. log_path)
    vim.cmd('set ft=log')
    vim.cmd('norm! G')
  end,
  name = 'View Amp logs',
})

-- ============================================================================
-- CODECOMPANION KEYMAPPINGS
-- ============================================================================

-- Toggle CodeCompanion chat
cosmos.add_leader_keymapping('n|ac', {
  '<cmd>CodeCompanionChat Toggle<cr>',
  name = 'CodeCompanion toggle',
})
