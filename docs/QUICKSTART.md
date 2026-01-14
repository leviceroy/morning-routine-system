# Quick Start Guide

Get your morning routine running in 5 minutes.

## Installation (2 minutes)

```bash
# Clone repository
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system

# Run setup
chmod +x scripts/setup.sh
./scripts/setup.sh
```

## Google Calendar Setup (3 minutes)

### 1. Get OAuth Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create project → Enable "Google Calendar API"
3. Create OAuth credentials (Desktop app)
4. Copy Client ID and Client Secret

### 2. Authenticate

```bash
source ~/gcalcli-venv/bin/activate
gcalcli init --noauth_local_server
```

Paste your Client ID and Secret when prompted, then authorize in browser.

## First Run

```bash
# Start Claude Code
claude

# Run morning routine
/morning-routine:main
```

You'll go through:
1. **Review yesterday** - Pattern analysis from last 3 days
2. **Morning check-in** - Quick reflection (mood, energy, sleep)
3. **Review goals** - Track progress (if you have goals)
4. **Schedule day** - Create calendar events for your priorities

## Create Your First Goal

```bash
# Create goal file
cp .claude/templates/goal.md Goals/Learn-Python.md

# Edit the goal
nano Goals/Learn-Python.md
```

**Example goal:**

```yaml
---
status: "In progress"
start: 2026-01-06
end: 2026-03-06
frequency: "Daily"
tags:
  - goal
  - learning
---

# Learn Python

## Prerequisites

I want to learn Python to automate tasks and build tools.

## Success Criteria

- [ ] Complete Python Crash Course book
- [ ] Build 3 small projects
- [ ] Contribute to open source project

## Log

- 2026-01-06: Goal created. Starting with Chapter 1.
```

## Daily Workflow

### Morning (15 minutes)

```bash
/morning-routine:main
```

**Tip:** Run this every morning at the same time for best results.

### Throughout the Day

Update your progress as you work:

```bash
# Add entry to goal log
nano Goals/Learn-Python.md

# Add to log section:
# - 2026-01-06: Completed Chapter 2. Lists are clearer now.
```

### Evening (5 minutes)

Create an evening check-in:

```bash
# Create evening note
nano "Daily/2026-01-06. Evening Check-in.md"
```

**Template:**

```markdown
---
date: 2026-01-06
---

# Evening check-in

## What I accomplished today

- Finished Chapter 2 of Python book
- Built first script (calculator)
- Set up development environment

## Challenges

- Virtual environments were confusing at first
- Syntax errors took time to debug

## What I learned

- Python indentation is critical
- Lists and dictionaries are powerful

## Tomorrow's commitments

- [ ] Complete Chapter 3
- [ ] Practice with exercises
```

The next morning, these notes will be analyzed for patterns!

## Tips for Success

### 1. Be Consistent

Run the morning routine **every day** at the same time. Consistency builds the habit.

### 2. Be Specific

When logging progress, use:
- ✅ **Specific:** "Completed 5 Python exercises on lists"
- ❌ **Vague:** "Made progress on Python"

### 3. Track Patterns

The system analyzes 3-day patterns. After 3 days, you'll see:
- Recurring accomplishments
- Persistent blockers
- Energy patterns

### 4. Use Calendar Events

Let the system create calendar events for you. Time-blocking ensures you actually work on priorities.

### 5. Review and Adjust

Every week, review your goals:
```bash
ls -la Goals/
```

Update status, adjust deadlines, add new goals.

## Example First Week

**Day 1 (Monday):**
- Run morning routine
- Answer check-in questions
- Create 1-2 goals
- Calendar events created automatically

**Day 2 (Tuesday):**
- Run morning routine
- See yesterday's snapshot
- Update goal progress
- Work on time-blocked tasks

**Day 3 (Wednesday):**
- Run morning routine
- **First pattern analysis appears!**
- See 3-day trends
- Adjust based on patterns

**Day 4-7:**
- Continue daily routine
- Patterns become clearer
- Habits solidify

## Keyboard Shortcuts

While in Claude Code:

- `/morning-routine:main` - Full workflow
- `/morning-routine:check-in` - Just morning check-in
- `/morning-routine:review-goals` - Just goal review
- `/morning-routine:schedule-day` - Just scheduling

## Customization

### Change Calendar Name

```bash
nano .claude/commands/morning-routine/schedule-day.md
```

Find `--calendar "YOUR_CALENDAR_NAME"` and replace with your actual calendar name.

### Change Reflection Questions

```bash
nano .claude/commands/morning-routine/check-in.md
```

Edit the questions in the file.

### Adjust Time Blocks

Default: 25-minute Pomodoros

To change:
```bash
nano .claude/commands/morning-routine/schedule-day.md
```

Find `--duration 25` and change to your preferred duration.

## Common Commands

### View calendar

```bash
source ~/gcalcli-venv/bin/activate
gcalcli agenda
```

### Add event manually

```bash
source ~/gcalcli-venv/bin/activate
gcalcli add --calendar "Your Calendar" \
  --title "Deep Work Session" \
  --when "09:00" \
  --duration 90 \
  --noprompt
```

### List calendars

```bash
source ~/gcalcli-venv/bin/activate
gcalcli list
```

### Search events

```bash
source ~/gcalcli-venv/bin/activate
gcalcli search "Python"
```

## What's Next?

- **[Configuration Guide](CONFIGURATION.md)** - Customize everything
- **[Troubleshooting](TROUBLESHOOTING.md)** - Fix common issues
- **[Full Documentation](../README.md)** - Deep dive into features

## Getting Help

- Check [Troubleshooting Guide](TROUBLESHOOTING.md)
- Open an issue on [GitHub](https://github.com/leviceroy/morning-routine-system/issues)
- Read [FAQ](TROUBLESHOOTING.md#faq)

---

**You're all set! Run `/morning-routine:main` tomorrow morning and start building better habits.** 🚀
