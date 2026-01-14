---
description: Schedule your day with calendar events and task list
allowed-tools:
  - Read
  - Write
  - Bash(gcalcli:*)
  - Bash(date:*)
  - Bash(source:*)
tags:
  - workflow-step
---

## Context

- **Today's Date:** !`date +%Y-%m-%d`
- **Current Time:** !`date +%H:%M`
- **Day of Week:** !`date +%A`
- **Calendar Name:** YOUR_CALENDAR_NAME (configure in gcalcli)
- **gcalcli Path:** `~/gcalcli-venv/bin/gcalcli`

## Your task

Help the user schedule their day by creating calendar events and a task list.

**CRITICAL: This workflow MUST create Google Calendar events. Do NOT skip calendar creation.**

**Process:**

1. **Understand the day:**
   - Recall tasks and priorities from the goal review session
   - Identify high-leverage tasks that should get time blocks
   - Note any fixed commitments (meetings, appointments)

2. **Build schedule with minimal questions:**
   - Use 25-minute Pomodoro blocks for focused work (50 min for double pomodoros)
   - Auto-schedule based on stated priorities
   - Only ask clarifying questions when truly ambiguous
   - Suggest time blocks (morning deep work, afternoon, etc.)

3. **MANDATORY: Create calendar events using gcalcli:**

   **⚠️ YOU MUST EXECUTE gcalcli commands - do not just document them!**

   - Use gcalcli to create events in Google Calendar
   - Works on macOS, Linux, and WSL2
   - Use full date format for reliability: `YYYY-MM-DD HH:MM`
   - Format:
     ```bash
     source ~/gcalcli-venv/bin/activate && gcalcli add \
       --calendar "YOUR_CALENDAR_NAME" \
       --title "Task Name" \
       --when "2026-01-12 14:00" \
       --duration 25 \
       --noprompt
     ```
   - For multiple events, chain commands with `&&`:
     ```bash
     source ~/gcalcli-venv/bin/activate && \
     gcalcli add --calendar "YOUR_CALENDAR_NAME" --title "Task 1" --when "2026-01-12 09:00" --duration 25 --noprompt && \
     gcalcli add --calendar "YOUR_CALENDAR_NAME" --title "Task 2" --when "2026-01-12 09:30" --duration 25 --noprompt && \
     gcalcli add --calendar "YOUR_CALENDAR_NAME" --title "Task 3" --when "2026-01-12 10:00" --duration 25 --noprompt
     ```

   **After creating events, VERIFY they were added:**
   ```bash
   source ~/gcalcli-venv/bin/activate && gcalcli agenda YYYY-MM-DD --nocolor
   ```

4. **Create Daily Tasks file:**
   Create `Daily/YYYY-MM-DD. Daily Tasks.md` with:
   - Time-blocked schedule matching the plan
   - Ranked priorities from goal review
   - Specific deliverables with clear outcomes
   - Success metrics for end of day
   - Key insights from morning check-in
   - Links to related goals

   **Format:**
   ```markdown
   # Daily Tasks - YYYY-MM-DD

   ## Schedule
   - **09:00 - 09:25** - [Task] - 25 min
   - **09:30 - 09:55** - [Task] - 25 min
   - **12:30 - 13:00** - Lunch - 30 min
   ...

   ## Priorities
   1. [ ] High-leverage task 1 (Goal: [[Goal Name]])
   2. [ ] High-leverage task 2
   3. [ ] ...

   ## Success Metrics
   - [ ] Completed X deliverable
   - [ ] Made progress on Y
   ...
   ```

5. **Confirm completion:**
   - Show checkmark ✅ when file created
   - Summarize schedule concisely

**Important:**
- 25-minute Pomodoro sessions with 5-minute breaks (breaks not in calendar)
- Default calendar: "YOUR_CALENDAR_NAME" (replace with your Google Calendar name)
- **ALWAYS use --noprompt flag** to avoid interactive prompts in WSL2
- Be concise - minimize preamble and postamble
- Auto-schedule intelligently to reduce back-and-forth
- **ALWAYS create calendar events** - only skip if gcalcli authentication explicitly fails with an error
- Time format: Use full datetime `YYYY-MM-DD HH:MM` (e.g., "2026-01-12 14:00")
- **After creating events, run gcalcli agenda to verify** - show user the events were created

**gcalcli Tips:**
- Check available calendars: `source ~/gcalcli-venv/bin/activate && gcalcli list`
- View today's agenda: `source ~/gcalcli-venv/bin/activate && gcalcli agenda`
- Delete event: `source ~/gcalcli-venv/bin/activate && gcalcli delete "Event Title"`
- Calendar names are case-sensitive (must match your Google Calendar name exactly)
