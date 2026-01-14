# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Repository Overview

Morning Routine System - An automated morning routine workflow for Claude Code that helps users start their day with clarity, focus, and intentionality.

**Repository:** `leviceroy/morning-routine-system`
**License:** MIT
**Current Version:** 1.1.0

## ⚠️ CRITICAL: Versioning Rules

When making changes to the Morning Routine System:

1. **Increment version by 0.1** for each update (e.g., v1.1 → v1.2 → v1.3)
2. **Only use different versioning** if the user explicitly requests it
3. **Update ALL version references** when incrementing:
   - `CLAUDE.md` - Current Version field above
   - `README.md` - Changelog section
   - `PACKAGE_SUMMARY.md` - Version field at bottom
   - `docker/Dockerfile` - LABEL version
   - `GITHUB_SETUP.md` - Social media example (if applicable)
4. **Add changelog entry** in README.md with date and bullet points of changes
5. **Commit message** should reference the new version

## Directory Structure

```
morning-routine-system/
├── .claude/
│   ├── agents/
│   │   └── morning-routine-expert.md  # AI agent definition
│   ├── commands/
│   │   └── morning-routine/           # Slash command definitions
│   │       ├── main.md                # Workflow orchestrator
│   │       ├── check-in.md            # Morning reflection
│   │       ├── review-yesterday.md    # Pattern analysis
│   │       ├── review-goals.md        # Goal tracking
│   │       └── schedule-day.md        # Calendar integration
│   └── templates/
│       ├── morning-checkin.md         # Daily note template
│       └── goal.md                    # Goal file template
├── Daily/                             # Daily notes directory
├── Goals/                             # Goal tracking files
├── docker/                            # Docker configuration
├── scripts/                           # Installation scripts
├── docs/                              # Documentation
└── examples/                          # Example configurations
```

---

## AI Agent: morning-routine-expert

### What is the Agent?

The `morning-routine-expert` is a Claude Code agent defined in `.claude/agents/morning-routine-expert.md`. Unlike slash commands that execute predefined steps, the agent is a conversational AI with:

- **Personality traits** - Enthusiastic, practical, direct, conversational
- **Adaptive behavior** - Adjusts responses based on user input
- **Context awareness** - Remembers earlier parts of the conversation
- **Decision making** - Can choose when to ask follow-up questions

### How the Agent Works

When spawned, the agent:

1. **Receives the conversation context** - Knows what the user said
2. **Invokes `/morning-routine:main`** - Runs the full 5-stage workflow
3. **Adapts to responses** - Asks intelligent follow-up questions
4. **Provides advice** - Offers productivity tips when relevant

### Agent vs Slash Commands

| Component | Type | Purpose |
|-----------|------|---------|
| `morning-routine-expert` | Agent | Conversational interface with personality |
| `/morning-routine:main` | Skill | Structured workflow execution |
| `/morning-routine:check-in` | Skill | Single stage: morning reflection |
| `/morning-routine:review-goals` | Skill | Single stage: goal tracking |
| `/morning-routine:schedule-day` | Skill | Single stage: calendar events |

**Key difference:** The agent adds personality and adaptability on top of the skills. The agent calls the skills internally.

### When to Use the Agent

The agent should be spawned when the user:
- Greets Claude in the morning ("Good morning", "Hey, just woke up")
- Asks to run the morning routine
- Asks for morning productivity advice
- Mentions starting their day

### Agent Invocation

The agent is invoked via Claude Code's Task tool:

```
Task tool with subagent_type: "morning-routine-expert"
```

This happens automatically when Claude detects morning routine intent.

---

## Workflow Stages

### 1. Review Yesterday (`/morning-routine:review-yesterday`)

- Reads last 3 days of daily files from `Daily/`
- Creates vivid reconstruction with timestamps
- Identifies patterns and recurring themes

### 2. Morning Check-in (`/morning-routine:check-in`)

- Presents reflection questions (mood, energy, sleep, focus)
- Creates `Daily/YYYY-MM-DD. Morning Check-in.md`
- Preserves user's authentic voice

### 3. Review Goals (`/morning-routine:review-goals`)

- Reads all goal files from `Goals/`
- Calculates progress percentages
- Generates contextual questions based on goal state
- Updates goal logs with progress

### 4. Schedule Day (`/morning-routine:schedule-day`)

- Creates calendar events via gcalcli
- Generates `Daily/YYYY-MM-DD. Daily Tasks.md`
- Uses 25-minute Pomodoro blocks

### 5. Complete Routine

- Logs total routine duration
- Summarizes what was accomplished

---

## File Conventions

### Daily Notes

```
Daily/YYYY-MM-DD. Morning Check-in.md
Daily/YYYY-MM-DD. Daily Tasks.md
Daily/YYYY-MM-DD. Evening Check-in.md
```

### Goal Files

Location: `Goals/`
Format: YAML frontmatter with status, dates, frequency

```yaml
---
status: "In progress"
start: 2026-01-06
end: 2026-03-06
frequency: "Daily"
tags:
  - goal
---

# Goal Name

## Prerequisites
[Context]

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Log
- YYYY-MM-DD: Progress entry
```

### Date Format

Always use ISO 8601: `YYYY-MM-DD`

### Calendar Events

Use full datetime format for gcalcli:
```bash
gcalcli add --when "2026-01-13 09:00" --duration 25
```

---

## Customization

### Modify Agent Personality

Edit `.claude/agents/morning-routine-expert.md`:

```markdown
Your personality:
- Enthusiastic about mornings but not annoyingly so
- Practical over theoretical
- Direct and honest
- Conversational and warm
```

### Modify Workflow Steps

Edit files in `.claude/commands/morning-routine/`:
- `main.md` - Change stage order or add stages
- `check-in.md` - Change reflection questions
- `review-goals.md` - Change goal question logic
- `schedule-day.md` - Change calendar settings

### Modify Templates

Edit files in `.claude/templates/`:
- `morning-checkin.md` - Daily note structure
- `goal.md` - Goal file structure

---

## Important Notes

### Calendar Integration

The system uses gcalcli for Google Calendar. Ensure:
1. gcalcli is installed and authenticated
2. Calendar name in `schedule-day.md` matches your actual calendar
3. Use full datetime format (`YYYY-MM-DD HH:MM`)

### Agent Model

The agent uses Sonnet by default (defined in agent frontmatter):
```yaml
model: sonnet
```

This can be changed to `opus` or `haiku` if needed.

### Workflow Progression

The workflow should progress automatically between stages. Only pause for user input when:
- User explicitly needs to answer questions
- A stage is entirely skipped

### Preserving User Voice

When creating notes, preserve the user's authentic voice. Do not:
- Polish or formalize their language
- Add unnecessary structure
- Change their tone or style
