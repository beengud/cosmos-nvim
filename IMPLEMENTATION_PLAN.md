# Amp Integration Analysis & Implementation Plan

## Current Setup Summary

Your cosmos-nvim config currently has:
- **amp.nvim** (sourcegraph/amp.nvim): Already installed, configured at line 130-139 in `lua/layers/completion/plugins.lua`
- **avante.nvim** (yetone/avante.nvim): Fully installed and heavily configured (lines 191-570)
- **codecompanion.nvim**: Configured as fallback AI
- **mcphub.nvim**: Model Control Protocol integration for MCP servers

## Amp.nvim vs Avante.nvim: Key Differences

### Amp.nvim (sourcegraph/amp.nvim)
**Purpose**: Bridge plugin connecting Neovim to Amp CLI agent

**Capabilities**:
- Notifies Amp about currently open file and cursor position
- Shares code selection with Amp agent
- Provides Neovim diagnostics on request
- Bidirectional communication: send messages to Amp, receive file edits
- **NOT** a standalone AI interface - requires `amp --ide` CLI running
- Minimal UI footprint (plugin acts as backend bridge)
- Works with Sourcegraph's Amp agent exclusively
- Automatic reconnection when Neovim restarts

**Use Case**: Secondary integration for CLI-driven Amp workflow

**Limitations**:
- Requires running `amp --ide` in terminal
- No built-in chat interface in Neovim
- Limited to Amp agent only

---

### Avante.nvim (yetone/avante.nvim)
**Purpose**: Full Neovim AI IDE emulating Cursor AI IDE

**Capabilities**:
- Full chat interface built into Neovim (sidebar, floating windows)
- Multi-provider support: Claude, OpenAI, Gemini, Copilot, Ollama, etc.
- **Agentic mode**: Auto-execute tools (file operations, bash, web search)
- **Legacy mode**: Conservative mode for sensitive work
- Custom tools & MCP server integration
- Project-specific instructions (`avante.md`)
- Session persistence and history
- Sophisticated diff/apply system
- **Fast Apply**: 96-98% accuracy code merge at 2500+ tokens/sec
- Code editing with AI suggestions
- Repository mapping for context
- RAG (Retrieval-Augmented Generation) support

**Use Case**: Primary AI development tool - self-contained within Neovim

**Advantages**:
- Complete IDE-like experience in Neovim
- Works offline (with local models like Ollama)
- No dependency on external CLI
- Multiple model providers
- Rich interaction modes

---

## Analysis: Which Should You Use?

### Option 1: Keep Both (Recommended)
Use each for its intended purpose:
- **Avante**: Primary workflow - in-editor chat, agentic tasks, code generation
- **Amp**: Secondary workflow - quick CLI-based prompts from terminal with `amp --ide`

**Pros**:
- Different interaction paradigms for different tasks
- Avante for complex in-editor work
- Amp for quick async CLI work
- No loss of capability

**Cons**:
- Plugin maintenance overhead
- Potential keybinding conflicts
- More memory footprint

---

### Option 2: Remove Avante, Enhance Amp
If you want simplicity and prefer CLI-driven workflow:

**Requirements**:
- Avante doesn't natively support "amp" as a provider
- Would need to fork/patch avante.nvim to add Amp provider support
- Significant development work

**Why it won't work well**:
- Amp.nvim is intentionally minimal (bridge, not IDE)
- You'd lose Avante's rich features (agentic mode, tools, diff UI, etc.)
- Not recommended

---

### Option 3: Optimize Current Setup (Recommended Approach)
Keep both but optimize configuration:

**Actions**:
1. Verify amp.nvim is fully functional
2. Ensure avante.nvim has optimal provider configuration
3. Create keyboard shortcuts for quick amp CLI invocation
4. Set up distinct layers/workflows for each tool

---

## Recommendation

**Keep both plugins** - they serve different needs:

1. **Avante** = IDE-like interface for complex refactoring, agentic workflows
2. **Amp** = CLI-driven for quick queries, when you're already in terminal

**Status**: Your amp.nvim is already installed and configured. No changes needed there.

---

## Next Steps

1. **Verify Amp CLI** is installed: `amp --version`
2. **Test amp.nvim** bridge: Run `amp --ide` in another terminal and verify connection
3. **Optimize keybindings** for quick access to both
4. **Clean up avante config** - your current config is excellent but might have unused providers
5. **Document in AGENTS.md** your preferred AI workflow

## Avante Provider Status

Avante.nvim currently supports these providers:
- Claude (Anthropic) ✓
- OpenAI ✓
- Gemini ✓
- Copilot ✓
- Ollama ✓
- Bedrock (AWS) ✓
- Moonshot ✓
- Custom HTTP endpoints ✓

**Amp is NOT listed as a native provider** - it's integrated via the separate amp.nvim plugin only.

