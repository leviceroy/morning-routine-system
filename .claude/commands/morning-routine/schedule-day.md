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
- **Calendar Name:** Chris Wenk (default calendar)
- **gcalcli Path:** `~/gcalcli-venv/bin/gcalcli`

## Your task

Help the user schedule their day by creating calendar events and a task list.

**Process:**

1. **Understand the day:**
   - Recall tasks and priorities from the goal review session
   - Identify high-leverage tasks that should get time blocks
   - Note any fixed commitments (meetings, appointments)

2. **Build schedule with minimal questions:**
   - Use 25-minute Pomodoro blocks for focused work
   - Auto-schedule based on stated priorities
   - Only ask clarifying questions when truly ambiguous
   - Suggest time blocks (morning deep work, afternoon, etc.)

3. **Create calendar events using gcalcli:**
   - Use gcalcli to create events in Google Calendar
   - Works on macOS, Linux, and WSL2
   - Format:
     ```bash
     source ~/gcalcli-venv/bin/activate && gcalcli add \
       --calendar "Chris Wenk" \
       --title "Task Name" \
       --when "14:00" \
       --duration 25 \
       --description "Optional description" \
       --noprompt
     ```
   - For multiple events, chain commands with `&&`:
     ```bash
     source ~/gcalcli-venv/bin/activate && \
     gcalcli add --calendar "Chris Wenk" --title "Task 1" --when "09:00" --duration 25 --noprompt && \
     gcalcli add --calendar "Chris Wenk" --title "Task 2" --when "09:30" --duration 25 --noprompt && \
     gcalcli add --calendar "Chris Wenk" --title "Task 3" --when "10:00" --duration 25 --noprompt
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
- Default calendar: "Chris Wenk" (user's main calendar)
- **ALWAYS use --noprompt flag** to avoid interactive prompts in WSL2
- Be concise - minimize preamble and postamble
- Auto-schedule intelligently to reduce back-and-forth
- If gcalcli authentication fails, gracefully skip calendar creation and just create the Daily Tasks file
- Time format: Use 24-hour format (e.g., "14:00", "09:30")

**gcalcli Tips:**
- Check available calendars: `source ~/gcalcli-venv/bin/activate && gcalcli list`
- View today's agenda: `source ~/gcalcli-venv/bin/activate && gcalcli agenda`
- Delete event: `source ~/gcalcli-venv/bin/activate && gcalcli delete "Event Title"`
- Calendar names are case-sensitive (e.g., "Chris Wenk" must match exactly)
