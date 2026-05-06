# InstallClaudeCode

## Description
Automates the installation and setup of Claude Code (the Anthropic CLI tool) with all dependencies and authentication.

---

## What This Script Does

I'm Dany from the Bat Library

This script is: **"Install Claude Code with automatic dependency checking and authentication setup"**

The plan is this:

1. Check if Node.js is installed; if not, offer to download it
2. Check if npm is installed; if missing, prompt to reinstall Node.js
3. Check if Claude Code is already installed; if yes, offer to update it
4. If not installed, install Claude Code globally via npm
5. Authenticate with your Anthropic account and complete setup

---

## Preview

### How it runs in CMD:

```
C:\Users\YourName\Projects> InstallClaudeCode.bat

 ============================================
  Claude Code Installer
 ============================================

[1/3] Checking Node.js...
 ✓ Node.js v20.10.0 found.

[2/3] Checking npm...
 ✓ npm 10.2.3 found.

[3/3] Checking for existing Claude Code install...
 ✓ Claude Code already installed: claude version 1.2.5

  Would you like to reinstall / update it?
   Reinstall? [Y/N]: N

 ============================================
  Authenticating with Anthropic
 ============================================

  This will open your browser to log in with your Anthropic account.
  (You need an account at https://claude.ai or https://console.anthropic.com)

 [Press any key to continue...]
```

### Expected Result:

If Claude Code is already installed and you skip reinstall:
```
 ============================================
  All done! Claude Code is ready.
 ============================================

  To start Claude Code, open any project folder in your terminal and run:

      claude

 [Press any key to continue...]
```

If you proceed with fresh installation:
```
  Installing Claude Code globally via npm...
  (This may take a minute)

 [NPM installation output...]

  ✓ Claude Code installed globally.

 ============================================
  Authenticating with Anthropic
 ============================================

  [Browser opens for login]
  [After authentication completes...]

 ============================================
  All done! Claude Code is ready.
 ============================================

  To start Claude Code, open any project folder in your terminal and run:

      claude

 [Press any key to continue...]
```

---

## Usage

1. **Run as Administrator** (recommended for global npm installs):
   - Right-click `InstallClaudeCode.bat`
   - Select "Run as administrator"

2. **Or run from command line**:
   ```bash
   InstallClaudeCode.bat
   ```

---

## Requirements

- **Windows 10/11** - Batch files run on Windows
- **Administrator privileges** - Required for global npm installations
- **Internet connection** - For downloading Node.js, npm packages, and authentication

## Prerequisites (Auto-Checked)

- ✓ Node.js (v14 or higher recommended)
- ✓ npm (comes with Node.js)
- ✓ Anthropic account (for authentication)

---

## What Happens During Execution

| Step | What it checks | If not found | If found |
|------|---|---|---|
| **1. Node.js** | Verifies Node.js is installed | Offers to download from nodejs.org | Shows version and continues |
| **2. npm** | Verifies npm package manager | Suggests reinstalling Node.js | Shows version and continues |
| **3. Claude Code** | Checks if Claude Code CLI exists | Proceeds to install | Offers to update or skip |
| **4. Installation** | Installs via npm globally | If fails: shows admin/connection tips | Success message |
| **5. Authentication** | Opens browser for Anthropic login | Allows retry | Sets up your account |

---

## Common Issues & Fixes

**"Access Denied" or "Permission Denied"**
- Run as Administrator

**"npm: The term 'npm' is not recognized"**
- Node.js/npm not in PATH
- Restart your terminal after installing Node.js

**"Installation failed"**
- Check your internet connection
- Try running as Administrator
- Try: `npm install -g @anthropic-ai/claude-code --force`

**"Authentication failed"**
- You can retry anytime by running: `claude auth login`
- Ensure you have an Anthropic account at https://claude.ai

---

## After Installation

Once complete, you can use Claude Code in any project:

```bash
cd C:\Users\YourName\MyProject
claude
```

This will start Claude Code in your project directory for agentic coding assistance.

---

## Notes

- Installation is **global** (available from any directory)
- You only need to run this script **once per machine**
- Authentication credentials are stored securely
- Updates can be run anytime by selecting "Reinstall" option
