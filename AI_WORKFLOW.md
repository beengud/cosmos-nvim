# AI Workflow: Amp + Avante Setup

## Overview

Your Neovim configuration now supports three AI tools, each optimized for different workflows:

1. **Avante.nvim** - IDE-like chat in Neovim (primary)
2. **Amp CLI + amp.nvim** - External agent with bridge (secondary)
3. **CodeCompanion.nvim** - Alternative IDE interface (fallback)

---

## Quick Start

### 1. Avante (In-Editor)

**Start using immediately**:
```vim
<leader>ae     " Toggle Avante sidebar
<leader>aa     " Ask about code
:AvanteAsk "your question"
```

**Features**:
- Full chat interface in sidebar
- Code diffs and apply
- Agentic mode (auto-execute tools)
- Multiple providers (Claude, OpenAI, Gemini, etc.)
- Works offline with Ollama

**Current config**:
- Provider: Claude (Anthropic)
- Model: claude-3-5-sonnet
- Max tokens: 8192
- Agentic mode: ON
- Web search: Enabled
- MCP tools: Enabled

---

### 2. Amp CLI + amp.nvim (Terminal-Driven)

**Start Amp bridge** (in separate terminal):
```bash
cd ~/your-project
amp --ide
```

**Use from Neovim**:
```vim
<leader>aam    " Send message to Amp
<leader>aac    " Send file context
<leader>aas    " Send selection (visual mode)
<leader>aar    " Add file reference (visual mode)
<leader>aah    " Health check
<leader>aal    " View logs
```

**Features**:
- Access full Amp smart mode (state-of-the-art models)
- Asynchronous (doesn't block editor)
- Oracle, subagents, advanced reasoning
- File edits sync back to Neovim

**Setup**:
- Auto-starts on Neovim launch
- Reconnects automatically
- Logs: `~/.cache/nvim/amp.log`

---

### 3. CodeCompanion (Fallback)

```vim
<leader>ac     " Toggle CodeCompanion chat
```

**Current config**:
- Provider: Ollama (http://100.92.182.127:11434)
- Model: devstral:24b
- Display: Enabled with diffs

---

## Workflow Scenarios

### Scenario 1: Quick Code Fix (In-Editor)
```vim
" Problem: TypeScript error in current file
<leader>aa
" Type: 'Fix the TypeScript error on line 42'
<cr>
" Avante applies fix automatically
```

### Scenario 2: Complex Refactoring (In-Editor)
```vim
" Want to refactor entire component
<leader>ae              " Open sidebar
" Select component code
<leader>aa
" Type: 'Refactor this component for better performance'
<cr>
" Review diffs and apply changes
```

### Scenario 3: Quick Async Query (CLI-Driven)
```vim
" You're coding but need to ask something complex
<leader>aam
" Type: 'What's the best way to handle concurrent requests in Node?'
<cr>
" Continues in background, use Amp web UI for full interaction
```

### Scenario 4: Complex Multi-File Changes (CLI-Driven)
```bash
# Terminal: Start Amp agent
$ amp --ide
amp> "Refactor auth system across these 5 files"
# Amp makes changes
# Sync back to Neovim with <leader>aac
```

### Scenario 5: Code Review with Oracle (CLI-Driven)
```bash
$ amp --ide
amp> "Review this API design and suggest improvements"  # Uses Oracle for deep analysis
# Compare with Avante's suggestions (different model)
```

---

## Key Bindings Reference

### Avante Bindings
| Binding | Action |
|---------|--------|
| `<leader>ae` | Toggle Avante sidebar |
| `<leader>aa` | Ask about code |
| `<leader>af` | Focus on Avante |
| Visual: `<leader>ae` | Edit selection with Avante |

### Amp Bindings
| Binding | Action |
|---------|--------|
| `<leader>aam` | Send message to Amp |
| `<leader>aac` | Send file context |
| `<leader>aas` | Send selection (visual) |
| `<leader>aar` | Add file reference (visual) |
| `<leader>aah` | Health check |
| `<leader>aal` | View logs |

### CodeCompanion
| Binding | Action |
|---------|--------|
| `<leader>ac` | Toggle chat |

---

## Provider Configuration

### Avante Providers
Your config has 30+ providers configured. Switch with:
```vim
:AvanteSwitchProvider
```

Popular options:
- **claude** - Claude 3.5 Sonnet (default)
- **openai** - GPT-4o
- **gemini** - Gemini 2.5 Pro
- **copilot** - GitHub Copilot
- **ollama** - Local model (http://100.92.182.127:11434)

### CodeCompanion Provider
- **ollama** - devstral:24b (local, fast)
- Can switch to **openai** for better quality

### Amp CLI
- Uses whatever you've configured in Amp (`amp config`)
- Default: Claude Opus 4.5 with 200k context
- Smart mode: Unconstrained model usage
- Free mode: Fast, basic models

---

## Environment Variables

### Avante/CodeCompanion
```bash
# Set your API keys (already configured in system)
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."
export GEMINI_API_KEY="..."
```

### Amp CLI
```bash
# Amp uses your account auth (login with: amp login)
amp login
# Or use Amp's smart mode credentials
```

---

## Troubleshooting

### Avante not responding
```vim
:checkhealth avante
```

Check:
- Provider credentials set (`echo $ANTHROPIC_API_KEY`)
- Network connectivity
- Provider not rate-limited

### Amp not connecting
```vim
:checkhealth amp
```

Check:
- Amp CLI running: `ps aux | grep "amp --ide"`
- In correct project directory
- View logs: `<leader>aal`

### CodeCompanion not working
```vim
:checkhealth codecompanion
```

Check:
- Ollama running (if local): `curl http://100.92.182.127:11434`
- Model available: `ollama list`

---

## Performance Tips

1. **Use Avante for** small-to-medium tasks (applies instantly)
2. **Use Amp for** complex/async tasks (doesn't block editor)
3. **Use CodeCompanion as** fast fallback (local Ollama)
4. **Monitor context usage** with Avante's token counter
5. **Set MCP servers** in mcphub.json for extended capabilities

---

## Advanced Features

### MCP Integration
Your config includes Model Control Protocol support via mcphub.nvim:
```vim
:MCPHub        " Manage MCP servers
```

Available tools:
- Web search
- File operations
- Code execution
- Custom tools

### Project Instructions
Create `avante.md` in your project root for custom instructions:
```markdown
# Project AI Guidelines

## Architecture
- Use React hooks for state
- Components in /components
- Styles with Tailwind

## Conventions
- 2-space indentation
- No class components
- Write tests with Vitest
```

---

## Comparing the Tools

### Avante ✓
- **Pro**: Works in Neovim, no alt-tab
- **Pro**: Agentic mode (auto-execute)
- **Pro**: Multiple providers
- **Pro**: Offline with Ollama
- **Con**: Blocked on long responses
- **Use for**: In-editor refactoring, quick fixes

### Amp CLI ✓
- **Pro**: Smart mode (SOTA models)
- **Pro**: Async (doesn't block)
- **Pro**: Oracle, subagents
- **Pro**: Terminal workflow
- **Con**: Requires alt-tab/split terminal
- **Con**: Requires CLI running
- **Use for**: Complex tasks, analysis, multi-file changes

### CodeCompanion ✓
- **Pro**: Fast (local Ollama)
- **Pro**: Alternative UI
- **Con**: Ollama quality limited
- **Con**: Requires Ollama running
- **Use for**: Quick local answers, brainstorming

---

## Recommended Daily Workflow

1. **Morning**: 
   - Start Neovim
   - Start `amp --ide` in background
   - Both AI tools ready

2. **Coding**:
   - Quick fixes: `<leader>aa` (Avante)
   - Complex tasks: Open Amp web UI or use `<leader>aam`
   - API decisions: Amp CLI with oracle

3. **Code Review**:
   - Use Avante for in-editor suggestions
   - Use Amp oracle for deeper analysis

4. **Debugging**:
   - Avante for quick "what's wrong"
   - Amp CLI for investigating patterns

---

## Configuration Files

- **Main Avante config**: `lua/layers/completion/plugins.lua` (lines 191-570)
- **Amp config**: `lua/layers/completion/plugins.lua` (lines 130-139)
- **Keymappings**: `lua/layers/completion/keymappings.lua` (all AI bindings)
- **CodeCompanion config**: `lua/layers/completion/plugins.lua` (lines 66-125)

---

## Next Steps

1. ✓ Verify Amp CLI works: `amp --version`
2. ✓ Test Avante: `<leader>ae` → ask a question
3. ✓ Start Amp bridge: Open terminal, run `amp --ide`
4. ✓ Test amp.nvim: `<leader>aam` → send test message
5. Create project `avante.md` with your conventions
6. Configure additional MCP servers if needed

---

## Questions & Feedback

- **Amp docs**: https://ampcode.com/manual
- **Avante repo**: https://github.com/yetone/avante.nvim
- **amp.nvim**: https://github.com/sourcegraph/amp.nvim
- **CodeCompanion**: https://github.com/olimorris/codecompanion.nvim

