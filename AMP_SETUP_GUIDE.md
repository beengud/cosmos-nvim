# Amp + Avante Setup Guide

## Status Check ✓

- **Amp CLI**: Installed ✓ (v0.0.1764811816)
- **amp.nvim plugin**: Installed ✓ (sourcegraph/amp.nvim)
- **avante.nvim plugin**: Installed ✓ (yetone/avante.nvim)
- **Lua language**: English ✓

## Quick Start

### 1. Start Amp CLI Bridge
In a separate terminal window (your primary workspace directory):

```bash
cd ~/your-project
amp --ide
```

This starts the Amp CLI agent and connects to Neovim through amp.nvim plugin.

### 2. Use in Neovim
Once `amp --ide` is running:

**Open a code file** → amp.nvim automatically notifies Amp of your current file/cursor position

**Interact with Amp** → Use the Amp CLI or web interface at localhost:8000

**Edits sync** → Changes made through Amp CLI appear in your Neovim buffers

---

## Workflow Comparison

### Amp CLI + amp.nvim
**When to use**: Quick prompts, async AI queries, terminal-driven development
```
Terminal:
$ amp --ide
amp> "Fix all TypeScript errors in ./src"
amp> "Look at localhost:3000 and report what you see"
```

**Advantages**:
- Works alongside Neovim
- Full state-of-the-art model access in Amp's smart mode
- Asynchronous (doesn't block editor)
- Can use Amp's advanced features (oracle, subagents, etc.)

---

### Avante in Neovim
**When to use**: Complex refactoring, in-editor chat, agentic tasks
```
Neovim:
<space>ae  → Start Avante
<space>ar  → Ask about current file
:AvanteAsk "Refactor this component"
```

**Advantages**:
- Full IDE experience without leaving Neovim
- Agentic mode can auto-execute tools
- Works offline with Ollama/local models
- Rich diff preview and apply system
- Session persistence

---

## Keybindings Setup

Add to your `~/.cosmos-nvim.lua` in the `after_setup` section:

```lua
after_setup = function()
  local cosmos = require('core.cosmos')
  
  -- Amp CLI Quick Send
  cosmos.add_leader_keymapping('n|ac', {
    '<cmd>!amp send_message<cr>',
    name = '[amp] Quick send to Amp',
  })
  
  -- Avante Quick Chat
  cosmos.add_leader_keymapping('n|ae', {
    '<cmd>AvanteToggle<cr>',
    name = '[avante] Toggle Avante',
  })
  
  cosmos.add_leader_keymapping('n|ar', {
    '<cmd>AvanteAsk<cr>',
    name = '[avante] Ask about code',
  })
end,
```

---

## Configuration Files

### amp.nvim
**Location**: `lua/layers/completion/plugins.lua` (lines 130-139)
**Status**: Minimal config, working as-is
**Setup mode**: `auto_start = true` (connects on Neovim startup)

### avante.nvim
**Location**: `lua/layers/completion/plugins.lua` (lines 191-570)
**Status**: Fully configured with multiple providers
**Current Provider**: Claude (default, line 231)
**Available Providers**: 30+ configured including OpenAI, Gemini, Ollama, Copilot

---

## Recommended Setup: "Dual Driver" Mode

### Setup Overview
- **Primary**: Avante for IDE work
- **Secondary**: Amp CLI for complex/async queries

### Implementation

**1. Ensure amp.nvim is loading** (already done in your config)
```lua
cosmos.add_plugin('sourcegraph/amp.nvim', {
  branch = 'main',
  lazy = false,
  config = function()
    require('amp').setup({
      auto_start = true,
      log_level = 'info',
    })
  end,
})
```

**2. Keep avante.nvim as primary** (already fully configured)
- Use for in-editor work with `:AvanteAsk` or `<leader>ae`

**3. Optional: Enhance amp.nvim with custom commands**

Add to your nvim config `after_setup`:
```lua
-- Send selected text to Amp
cosmos.add_leader_keymapping('v|as', {
  ':AmpPromptSelection<cr>',
  name = '[amp] Send selection to Amp',
})

-- Send file reference to Amp prompt
cosmos.add_leader_keymapping('n|af', {
  ':AmpPromptRef<cr>',
  name = '[amp] Add file ref to Amp',
})
```

---

## Troubleshooting

### "amp.nvim not connecting"
```bash
# Check amp CLI is running
ps aux | grep "amp --ide"

# Check amp.nvim plugin loaded
nvim +checkhealth amp

# View logs
tail ~/.cache/nvim/amp.log
```

### "Avante not responding"
```bash
# Verify provider credentials
echo $ANTHROPIC_API_KEY  # or relevant API key

# Check avante health
nvim +checkhealth
```

### Both plugins interfering
- They shouldn't conflict - different interaction models
- Amp.nvim is passive (waits for CLI)
- Avante is active (user-initiated in editor)

---

## MCP Integration

Your config includes **mcphub.nvim** which bridges Model Control Protocol servers.

This means Avante can use MCP tools for:
- Web search
- File operations
- Code execution
- Custom tools

This is already configured (line 211-218 in plugins.lua).

---

## Performance Notes

- **Memory**: amp.nvim adds ~2-5MB, avante.nvim ~20-30MB (normal for IDE plugins)
- **Startup**: amp.nvim lazy loads on demand
- **Token usage**: Controlled per provider (Claude, Ollama, etc.)

---

## Next: Test Everything

### Test 1: Verify amp.nvim
```bash
# Terminal 1: Start Neovim
nvim

# Terminal 2: Start Amp CLI
cd ~/your-project
amp --ide

# In Neovim: Run healthcheck
:checkhealth amp
```

### Test 2: Verify avante.nvim
```vim
" In Neovim
:checkhealth avante
" Should show provider status and configuration
```

### Test 3: Try workflows
```vim
" In Neovim editor
:AvanteToggle       " Start Avante sidebar
:AvanteAsk "Help"   " Ask a question
" Type a message and press Enter to send
```

---

## Your Ideal Environment

Based on analysis:

✓ **Keep amp.nvim** - for CLI-driven Amp workflow
✓ **Keep avante.nvim** - for IDE-like in-editor experience
✓ **Keep codecompanion.nvim** - as fallback
✗ **No changes needed to avante.nvim** - it's excellently configured

You have the best setup: multiple tools, each optimized for different workflows.

