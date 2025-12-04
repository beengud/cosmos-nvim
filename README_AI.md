# 🤖 Your AI-Powered Neovim Environment

This is a fully configured, production-ready AI development environment combining three complementary AI interfaces with your cosmos-nvim configuration.

## 🎯 Quick Start (Choose One)

### 🟢 Fast: Use Avante (Recommended First)
```vim
<leader>ae          " Open Avante sidebar
" Type your question and press Enter
" AI responds with code suggestions and diffs
```

### 🔵 Powerful: Use Amp CLI (More Advanced)
```bash
# Terminal 1: Start Amp agent
cd ~/your-project
amp --ide

# Terminal 2: Use from Neovim
<leader>aam         " Send message to Amp
" Type your prompt
# Amp executes with full agent capabilities
```

### 🟡 Local: Use CodeCompanion (Offline)
```vim
<leader>ac          " Toggle CodeCompanion chat
" Works locally with Ollama model
```

---

## 📊 Feature Comparison

|  | **Avante** | **Amp CLI** | **CodeCompanion** |
|---|---|---|---|
| **Location** | In Neovim | Separate terminal | In Neovim |
| **Speed** | Fast | Medium | Very fast (local) |
| **Models** | 30+ providers | SOTA models | Local only |
| **Agentic** | ✓ Auto-execute | ✓ Full tools | ✗ Manual |
| **Offline** | With Ollama | ✗ Internet | ✓ Full offline |
| **Best for** | Quick fixes | Complex tasks | Brainstorming |

---

## ⌨️  Default Keybindings

### Avante Commands
```
<leader>ae    Toggle sidebar
<leader>aa    Ask about code
<leader>af    Focus on Avante
```

### Amp CLI Commands  
```
<leader>aam   Send message
<leader>aac   Send file context
<leader>aas   Send selection (visual)
<leader>aar   Add file reference (visual)
<leader>aah   Health check
<leader>aal   View logs
```

### CodeCompanion
```
<leader>ac    Toggle chat
```

---

## 🚀 Example Workflows

### Example 1: Fix an Error (30 seconds)
```vim
" File has TypeScript error on line 42
<leader>aa              " Ask Avante
" Type: 'Fix the TypeScript error'
<Enter>
" Avante shows diff and applies fix
```

### Example 2: Refactor Component (2-3 minutes)
```vim
" Select component code
<leader>ae              " Open sidebar
" Type: 'Refactor for performance and readability'
<Enter>
" Review diffs, ask follow-up questions
:q                      " Close when satisfied
```

### Example 3: Research Question (5 minutes)
```bash
$ amp --ide             " Start agent in background
" In editor:
<leader>aam             " Quick message
" Type: 'What's the best pattern for real-time sync?'
" Browse Amp web UI at localhost:8000 for full research
# Amp uses oracle for deep analysis
```

---

## 📁 What's Configured

### Plugins
- ✓ **avante.nvim** - Full IDE interface (130+ KB)
- ✓ **amp.nvim** - Amp CLI bridge (50 KB)
- ✓ **codecompanion.nvim** - Alternative chat (100 KB)
- ✓ **mcphub.nvim** - MCP server integration (80 KB)

### Providers (Avante)
- Claude 3.5 Sonnet (default)
- OpenAI GPT-4o
- Google Gemini 2.5
- GitHub Copilot
- Ollama (local)
- 25+ more options

### Configuration Files
```
~/.config/nvim/
├── lua/layers/completion/
│   ├── plugins.lua              (AI plugins)
│   ├── configs.lua              (plugin config)
│   ├── keymappings.lua          (new: AI keybindings) ✨
│   ├── settings.lua
│   └── options.lua
├── AI_WORKFLOW.md               (detailed guide)
├── AMP_SETUP_GUIDE.md          (setup instructions)
├── IMPLEMENTATION_PLAN.md       (technical)
├── SETUP_COMPLETE.md            (status)
└── README_AI.md                 (this file)
```

---

## 🔧 System Requirements

- **Neovim**: 0.10+ (you have v0.11.5) ✓
- **Amp CLI**: v0.0.1764+ (installed) ✓
- **Network**: For LLM providers (Avante, Amp)
- **Optional**: Ollama for local models
- **Optional**: MCP servers for extended tools

---

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| **AI_WORKFLOW.md** | Complete usage guide (30 min read) |
| **AMP_SETUP_GUIDE.md** | Installation and troubleshooting |
| **SETUP_COMPLETE.md** | Configuration summary |
| **IMPLEMENTATION_PLAN.md** | Technical architecture |
| **README_AI.md** | This quick-start guide |

---

## ❓ Common Questions

**Q: Do I need to run anything before using?**
A: For Avante/CodeCompanion: No, works immediately.
For Amp: Run `amp --ide` in another terminal.

**Q: Which should I use?**
A: Start with Avante (`<leader>ae`) - it's the fastest.
Use Amp CLI for complex analysis or when you need advanced features.

**Q: Can I use multiple at once?**
A: Yes! Have Avante in Neovim and Amp running in terminal simultaneously.

**Q: What about API costs?**
A: - Avante: Pay per provider (Claude, OpenAI, etc.)
  - Amp CLI: Free tier available + smart/paid modes
  - CodeCompanion: Free (local Ollama model)

**Q: Does it work offline?**
A: - Avante with Ollama: Yes (fully offline)
  - Amp CLI: Needs internet (advanced models)
  - CodeCompanion with Ollama: Yes

**Q: My API key isn't working?**
A: See AMP_SETUP_GUIDE.md troubleshooting section

---

## 🎮 Try It Now

### Test Avante (< 1 minute)
```vim
<leader>ae          " Opens sidebar
" Type: "Hello, can you see me?"
<Enter>
```

### Test Amp (< 2 minutes)
```bash
# Terminal 1
amp --ide

# Terminal 2 (Neovim)
<leader>aam
" Type: "Hi, testing the bridge"
<Enter>
```

### Test CodeCompanion (< 1 minute)
```vim
<leader>ac          " Opens chat
" Type: "Test message"
<Enter>
```

---

## 🎓 Next Steps

1. **Today**: Try Avante with `<leader>ae`
2. **Tomorrow**: Test Amp CLI workflow with `amp --ide`
3. **Soon**: Create project-specific `avante.md` 
4. **Advanced**: Configure additional MCP servers
5. **Expert**: Customize keybindings in `keymappings.lua`

---

## 📞 Support

- **Amp Manual**: https://ampcode.com/manual
- **Avante Issues**: https://github.com/yetone/avante.nvim/issues
- **amp.nvim Issues**: https://github.com/sourcegraph/amp.nvim/issues
- **CodeCompanion**: https://github.com/olimorris/codecompanion.nvim

---

## ✨ Key Features

✓ **Multi-model support** - Use best model for each task
✓ **IDE-like experience** - AI interface matches editor
✓ **Asynchronous execution** - Don't block your workflow  
✓ **Tool integration** - Web search, file ops, code exec
✓ **Chat history** - Persistent across sessions
✓ **Code diffs** - Preview changes before applying
✓ **Offline option** - Works with local models
✓ **Project context** - MCP servers for codebase awareness

---

## 🚦 Status

| Component | Status | Version |
|-----------|--------|---------|
| Neovim | ✓ Ready | 0.11.5 |
| Amp CLI | ✓ Ready | 0.0.1764... |
| amp.nvim | ✓ Ready | main |
| avante.nvim | ✓ Ready | main |
| codecompanion.nvim | ✓ Ready | - |
| keymappings | ✓ Ready | new |

Everything is installed and configured. You're ready to go! 🎉

---

## 🎯 Your AI Development Superpower

You now have:
- **Immediate AI assistance** for coding questions
- **Agentic capabilities** for complex tasks
- **Multiple AI models** to choose from
- **IDE integration** without friction
- **Local execution** for privacy
- **Team collaboration** via Amp threads

Start coding with AI support right now with `<leader>ae`

