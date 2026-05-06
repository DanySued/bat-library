# BAT File Structure Template

This template defines the standard structure for all `.bat` files in the Bat Library.

## Template Format

Every `.bat` file should follow this structure:

### 1. **Welcome Section** (in the script)
- Greeting with author name (Dany from the Bat Library)
- Brief description of what the script does

### 2. **The Plan Section**
- Numbered list of steps the script will execute
- Use format: `1. check if ...`, `2. if installed, ...`, etc.

### 3. **Preview Section** (in README or documentation)
- Shows how the script will look and behave in CMD
- Includes simulated command line output
- Shows the final result/outcome

### 4. **Script Implementation**
- Comment sections using `:: ─── [Section Name] ───`
- Clear step numbering
- Error handling with informative messages
- Visual feedback (✓ for success, ✗ for errors)

---

## Markdown Documentation Template

Each script should have a corresponding markdown file with:

```markdown
# [Script Name]

## Description
Brief explanation of what this script does.

## What This Script Does
I'm Dany from the Bat Library

This script is: "[one-line description]"
The plan is this:

1. [First step]
2. [Second step]
3. [Third step]
4. [Last step - usually completion]

## Preview

### How it runs in CMD:
\`\`\`
[Simulated command line execution showing prompts and user inputs]
\`\`\`

### Expected Result:
\`\`\`
[Simulated final output showing what happens after completion]
\`\`\`

## Usage
\`\`\`bash
[How to run the script]
\`\`\`

## Requirements
- [Requirement 1]
- [Requirement 2]

## Notes
- [Any important notes]
```

---

## Example: InstallClaudeCode Script

See `InstallClaudeCode.md` for a complete example implementation.
