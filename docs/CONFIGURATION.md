# Configuration Guide

Customize your morning routine to fit your workflow.

## Table of Contents

- [Calendar Configuration](#calendar-configuration)
- [Workflow Customization](#workflow-customization)
- [Question Customization](#question-customization)
- [Time Block Settings](#time-block-settings)
- [Goal Tracking](#goal-tracking)
- [Advanced Configuration](#advanced-configuration)

---

## Calendar Configuration

### Change Calendar Name

**File:** `.claude/commands/morning-routine/schedule-day.md`

```bash
# Find this line:
--calendar "YOUR_CALENDAR_NAME"

# Change to your actual calendar name:
--calendar "Work"
# or
--calendar "Personal"
```

### List Your Calendars

```bash
source ~/gcalcli-venv/bin/activate
gcalcli list
```

**Output example:**
```
Access  Title
------  -----
owner   Personal
owner   Work
reader  Holidays in United States
```

Use the exact name from the "Title" column (case-sensitive).

### Use Multiple Calendars

To create events in different calendars based on task type:

**Edit:** `.claude/commands/morning-routine/schedule-day.md`

```bash
# Work tasks → Work calendar
gcalcli add --calendar "Work" --title "Team Meeting" ...

# Personal tasks → Personal calendar
gcalcli add --calendar "Personal" --title "Gym" ...
```

### Change Time Zone

gcalcli uses your system timezone by default.

**Check current timezone:**
```bash
timedatectl
```

**Change timezone (Linux):**
```bash
sudo timedatectl set-timezone America/New_York
```

**Available timezones:**
```bash
timedatectl list-timezones
```

---

## Workflow Customization

### Disable Specific Stages

To skip a stage, comment it out in `main.md`:

**File:** `.claude/commands/morning-routine/main.md`

```markdown
<!-- Comment out review-yesterday if you don't want it
2. **Review yesterday:**
   - Run `/morning-routine:review-yesterday` to get yesterday's snapshot and 3-day patterns
   - Automatically proceed to step 3
-->
```

### Change Stage Order

Reorder steps in `main.md`:

```markdown
## Your task

1. **Morning check-in:**      # Moved to first
2. **Review yesterday:**       # Moved to second
3. **Review goals:**
4. **Schedule the day:**
```

### Add Custom Stages

Create a new command file:

```bash
# Create new stage
nano .claude/commands/morning-routine/evening-review.md
```

**Template:**

```yaml
---
description: Evening reflection on the day
allowed-tools:
  - Read
  - Write
  - Bash(date:*)
tags:
  - workflow-step
---

## Context

- **Today's Date:** !`date +%Y-%m-%d`

## Your task

Help the user reflect on their day.

**Questions:**
1. What went well today?
2. What challenges did you face?
3. What will you do differently tomorrow?

Create `Daily/YYYY-MM-DD. Evening Review.md` with responses.
```

Add to `main.md`:
```markdown
5. **Evening review:**
   - Run `/morning-routine:evening-review`
```

---

## Question Customization

### Morning Check-in Questions

**File:** `.claude/commands/morning-routine/check-in.md`

**Current questions:**
```markdown
## Morning Check-in Questions

**How are you feeling right now?** (mood, energy level)

**How was your sleep last night?** (quality, any notes)

**What's your main focus for today?**

**What would make today successful?**

**Any ideas or thoughts on your mind?**
```

**Add custom questions:**

```markdown
**What are you grateful for today?**

**What's your #1 priority?**

**Who do you need to connect with today?**

**What's one thing you'll do for your health?**
```

### Goal Review Questions

The system generates contextual questions automatically, but you can customize the logic:

**File:** `.claude/commands/morning-routine/review-goals.md`

**Edit the contextual question generation:**

```markdown
**Contextual Question Generation:**

The goal review stage generates questions based on:
1. **"Next review:" questions** in recent log entries (takes precedence)
2. **Context-based questions:**
   - Active work goals: "What's the ONE thing that must get done today?"
   - Near deadline (<7 days): "You have X days left. Are you on track?"
   - Blockers mentioned: "What's blocking you? How can we address it?"
   - Backlog goals: "Which idea resonates most? What would the outline look like?"

# Add your own contexts:
   - Long-term goals (>90 days): "What small step brings you closer today?"
   - Health goals: "How will you prioritize your wellbeing?"
```

---

## Time Block Settings

### Change Pomodoro Duration

**File:** `.claude/commands/morning-routine/schedule-day.md`

```bash
# Find:
--duration 25

# Change to:
--duration 50  # 50-minute blocks
--duration 90  # 90-minute deep work
--duration 15  # 15-minute quick tasks
```

### Time Format Best Practices

**Recommended:** Use full datetime format for reliability:

```bash
# Full datetime format (recommended - works reliably)
--when "2026-01-12 14:00"

# Simple time format (same day only)
--when "14:00"
```

The full datetime format (`YYYY-MM-DD HH:MM`) ensures events are created on the correct date, especially when running the routine late in the day or across midnight.

### Adjust Break Times

Breaks are not added to calendar by default. To add them:

```bash
# After each work block, add a break:
gcalcli add --calendar "Work" --title "Task 1" --when "09:00" --duration 25 --noprompt && \
gcalcli add --calendar "Work" --title "Break" --when "09:25" --duration 5 --noprompt && \
gcalcli add --calendar "Work" --title "Task 2" --when "09:30" --duration 25 --noprompt
```

### Change Start Time

**File:** `.claude/commands/morning-routine/schedule-day.md`

```markdown
## Context

- **Default Start Time:** 09:00
```

The system will suggest starting at this time unless you specify otherwise.

### Add Lunch Break

Automatically add lunch to schedule:

```bash
# In schedule-day.md, add:
gcalcli add --calendar "Work" --title "Lunch" --when "12:00" --duration 60 --noprompt
```

---

## Goal Tracking

### Goal File Template

**File:** `.claude/templates/goal.md`

**Customize fields:**

```yaml
---
status: "Not started"
start: YYYY-MM-DD
end: YYYY-MM-DD
frequency: "Daily"
priority: "High"        # Add custom field
category: "Work"        # Add custom field
tags:
  - goal
---
```

### Progress Bar Calculation

**File:** `.claude/commands/morning-routine/review-goals.md`

**Current formula:**
```
Progress = (days_elapsed / total_days) * 100
```

**Change to milestone-based:**

```markdown
## Success Criteria

- [x] Criterion 1 (25%)
- [x] Criterion 2 (25%)
- [ ] Criterion 3 (25%)
- [ ] Criterion 4 (25%)

Progress: 50% complete
```

### Goal Frequency Options

In your goal files:

```yaml
frequency: "Daily"     # Review every day
frequency: "Weekly"    # Review once per week
frequency: "Monthly"   # Review once per month
frequency: "Quarterly" # Review every 3 months
```

---

## Advanced Configuration

### Custom File Naming

**File:** `.claude/commands/morning-routine/check-in.md`

```markdown
# Current format:
Daily/YYYY-MM-DD. Morning Check-in.md

# Change to:
Daily/check-ins/YYYY-MM-DD-morning.md
```

### Integration with Other Tools

#### Notion

Export daily notes to Notion using Notion API:

```bash
# Create script: scripts/export-to-notion.sh
#!/bin/bash
DATE=$(date +%Y-%m-%d)
DAILY_NOTE="Daily/$DATE. Morning Check-in.md"

curl -X POST https://api.notion.com/v1/pages \
  -H "Authorization: Bearer $NOTION_TOKEN" \
  -H "Content-Type: application/json" \
  -d @$DAILY_NOTE
```

#### Todoist

Sync tasks to Todoist:

```bash
# Install todoist-python
pip install todoist-python

# Create sync script
python scripts/sync-todoist.py
```

#### Apple Reminders (macOS)

```bash
# Add reminder via AppleScript
osascript -e 'tell application "Reminders"
  make new reminder with properties {name:"Review morning routine"}
end tell'
```

### Webhook Notifications

Get notified when routine completes:

**File:** `.claude/commands/morning-routine/main.md`

```bash
# At end of routine:
curl -X POST https://your-webhook-url.com/routine-complete \
  -H "Content-Type: application/json" \
  -d '{"status":"complete","time":"'$(date +%H:%M)'"}'
```

### Backup Configuration

Auto-backup daily notes to cloud:

```bash
# Create backup script
#!/bin/bash
DATE=$(date +%Y-%m-%d)
rsync -av Daily/ ~/Dropbox/morning-routine-backup/Daily/
rsync -av Goals/ ~/Dropbox/morning-routine-backup/Goals/
```

Add to cron:
```bash
crontab -e

# Run backup daily at midnight
0 0 * * * /path/to/backup-script.sh
```

---

## Environment Variables

Create `.env` file for sensitive configuration:

```bash
# .env
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
CALENDAR_NAME=Work
DEFAULT_DURATION=25
START_TIME=09:00
WEBHOOK_URL=https://your-webhook.com
```

Load in scripts:
```bash
source .env
gcalcli add --calendar "$CALENDAR_NAME" --duration "$DEFAULT_DURATION" ...
```

---

## Configuration Files Reference

| File | Purpose | Key Settings |
|------|---------|--------------|
| `main.md` | Workflow orchestration | Stage order, progression |
| `check-in.md` | Morning questions | Reflection prompts |
| `review-yesterday.md` | Pattern analysis | Days to analyze |
| `review-goals.md` | Goal tracking | Question generation logic |
| `schedule-day.md` | Calendar integration | Calendar name, time blocks |
| `.claude/templates/goal.md` | Goal template | YAML structure |
| `.claude/templates/morning-checkin.md` | Check-in template | Note format |

---

## Best Practices

1. **Start simple** - Use defaults for first week, then customize
2. **One change at a time** - Test changes before adding more
3. **Backup before changes** - Copy files before editing
4. **Document customizations** - Comment your changes in files
5. **Share configurations** - Contribute useful configs back to community

---

## Next Steps

- Check [Troubleshooting Guide](TROUBLESHOOTING.md) if customizations cause issues
- See [examples/](../examples/) for pre-made configurations
- Share your config in [GitHub Discussions](https://github.com/leviceroy/morning-routine-system/discussions)
