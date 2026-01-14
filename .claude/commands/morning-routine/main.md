---
description: Complete morning routine workflow
allowed-tools:
  - SlashCommand
  - Bash(osascript:*)
  - Bash(open:*)
  - Bash(date:*)
status: active
tags:
  - workflow
---

## Context

- **Routine Start Time:** !`date +"%H:%M"`
- **Today:** !`date +"%A, %Y-%m-%d"`

## Your task

Orchestrate the complete morning routine by executing stages in sequence.

1. **Review yesterday:**
   - Run `/morning-routine:review-yesterday` to get yesterday's snapshot and 3-day patterns
   - Automatically proceed to step 2

2. **Morning check-in:**
   - Run `/morning-routine:check-in`
   - User reflects on yesterday's context while answering questions
   - Automatically proceed to step 3

3. **Review goals:**
   - Run `/morning-routine:review-goals`
   - Interactive Q&A about active goals
   - Automatically proceed to step 4

4. **Schedule the day:**
   - Run `/morning-routine:schedule-day`
   - **MUST create Google Calendar events using gcalcli** (do not skip!)
   - Creates Daily Tasks file with time-blocked schedule
   - Verify events appear in Google Calendar before proceeding
   - Automatically proceed to step 5

5. **Complete the routine:**
   - Log routine duration
   - Show: "Morning routine completed: [start time] - [current time]. Ready to start your day!"

**Critical:** Automatically proceed through all stages (1-5) without pausing.
