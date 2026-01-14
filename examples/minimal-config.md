# Minimal Configuration Example

A barebones morning routine setup for users who want just the essentials.

## Features

- Morning check-in only (no goal tracking)
- Simple yes/no questions
- No calendar integration
- Fast (~2 minutes total)

## Installation

Copy this configuration to your `.claude/commands/morning-routine/` directory.

## Files

### main.md (simplified)

```yaml
---
description: Minimal morning routine workflow
---

## Your task

Run a quick morning check-in.

1. **Morning check-in:**
   - Run `/morning-routine:check-in`
   - Quick reflection questions

2. **Complete:**
   - Log duration
   - Show completion message
```

### check-in.md (simplified)

```yaml
---
description: Quick morning check-in
allowed-tools:
  - Write
  - Bash(date:*)
---

## Your task

Quick morning reflection.

**Questions:**

1. How are you feeling? (1-10)
2. What's your #1 priority today?
3. What would make today successful?

Create `Daily/YYYY-MM-DD. Morning Check-in.md` with responses.
```

## Usage

```bash
/morning-routine:main
```

Takes ~2 minutes. Perfect for busy mornings!

## Customization

Add more questions by editing `check-in.md`.

## Upgrade Path

When ready for more features:
1. Add goal tracking - copy `review-goals.md`
2. Add calendar - copy `schedule-day.md`
3. Add pattern analysis - copy `review-yesterday.md`
