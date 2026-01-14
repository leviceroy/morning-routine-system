# Troubleshooting Guide

Solutions to common issues with the Morning Routine System.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Google Calendar Issues](#google-calendar-issues)
- [WSL2 Specific Issues](#wsl2-specific-issues)
- [Docker Issues](#docker-issues)
- [Workflow Issues](#workflow-issues)
- [FAQ](#faq)

---

## Installation Issues

### Python Version Too Old

**Error:** `Python 3.8+ required, found 3.6`

**Solution:**

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3.9 python3.9-venv

# macOS
brew install python@3.9

# Verify
python3.9 --version
```

### Virtual Environment Creation Fails

**Error:** `Error: [Errno 1] Operation not permitted`

**Cause:** Trying to create venv on Windows filesystem from WSL2

**Solution:**

```bash
# Create venv in WSL2 home directory, not Windows drive
cd ~
python3 -m venv gcalcli-venv
source gcalcli-venv/bin/activate
pip install gcalcli
```

### pip Install Fails

**Error:** `externally-managed-environment`

**Solution:**

Use virtual environment (don't install system-wide):

```bash
python3 -m venv ~/gcalcli-venv
source ~/gcalcli-venv/bin/activate
pip install gcalcli
```

### Permission Denied on Scripts

**Error:** `Permission denied: ./scripts/setup.sh`

**Solution:**

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

---

## Google Calendar Issues

### Access Blocked: App Not Verified

**Error:** "Access blocked: This app hasn't been verified by Google"

**Solution:**

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to "APIs & Services" → "OAuth consent screen"
3. Scroll to "Test users"
4. Click "Add Users"
5. Enter your email address
6. Save
7. Try authentication again

### OAuth Localhost Connection Refused

**Error:** `Can't access http://localhost:48867`

**Cause:** WSL2 networking issue with OAuth callback

**Solution:**

Use no-browser mode:

```bash
gcalcli init --noauth_local_server
```

This will:
1. Show you a URL to open manually
2. You authorize in browser
3. Copy authorization code back to terminal

### Calendar Not Found

**Error:** `Calendar 'Work' not found`

**Cause:** Calendar name doesn't match exactly (case-sensitive)

**Solution:**

```bash
# List exact calendar names
source ~/gcalcli-venv/bin/activate
gcalcli list

# Use exact name from output (case-sensitive)
gcalcli add --calendar "Work" ...  # Not "work" or "WORK"
```

### Token Expired

**Error:** `Token has been expired or revoked`

**Solution:**

Re-authenticate:

```bash
source ~/gcalcli-venv/bin/activate

# Remove old credentials
rm -rf ~/.gcalcli_oauth

# Re-initialize
gcalcli init --noauth_local_server
```

### Events Not Appearing

**Problem:** Command succeeds but events don't show in Google Calendar

**Checklist:**

1. **Verify calendar name:**
   ```bash
   gcalcli list
   ```

2. **Check event was created:**
   ```bash
   gcalcli agenda
   ```

3. **Verify time format:**
   ```bash
   # Correct: Full datetime format (recommended)
   --when "2026-01-12 14:00"

   # Also correct: 24-hour format (same day only)
   --when "14:00"

   # Incorrect:
   --when "2:00pm"
   ```

4. **Check timezone:**
   ```bash
   timedatectl
   ```

5. **Refresh Google Calendar:**
   - Open calendar.google.com
   - Hard refresh (Ctrl+Shift+R)

### Schedule-Day Creates File But Skips Calendar Events

**Problem:** The schedule-day command creates the Daily Tasks markdown file but doesn't add events to Google Calendar

**Cause:** The AI documented the schedule but didn't actually execute the gcalcli commands

**Solution:**

1. The schedule-day command MUST execute gcalcli commands, not just document them
2. Use full datetime format for reliability: `--when "YYYY-MM-DD HH:MM"`
3. Always verify events were created after running gcalcli:
   ```bash
   source ~/gcalcli-venv/bin/activate && gcalcli agenda YYYY-MM-DD --nocolor
   ```
4. If calendar events are missing, manually add them:
   ```bash
   source ~/gcalcli-venv/bin/activate && \
   gcalcli add --calendar "YOUR_CALENDAR_NAME" --title "Task" --when "YYYY-MM-DD HH:MM" --duration 25 --noprompt
   ```

**Prevention:** The schedule-day.md command file has been updated with CRITICAL/MANDATORY instructions to ensure calendar events are always created

---

## WSL2 Specific Issues

### Command Not Found: gcalcli

**Error:** `gcalcli: command not found`

**Cause:** Virtual environment not activated

**Solution:**

```bash
source ~/gcalcli-venv/bin/activate
gcalcli --version
```

**Permanent solution** - Add to `~/.bashrc`:

```bash
echo 'alias gcalcli="source ~/gcalcli-venv/bin/activate && gcalcli"' >> ~/.bashrc
source ~/.bashrc
```

### Browser Doesn't Open

**Problem:** `gcalcli init` doesn't open browser in WSL2

**Solution:**

1. Use `--noauth_local_server` flag
2. Or configure WSL2 to open Windows browser:

```bash
# Add to ~/.bashrc
export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
```

### Slow File Access

**Problem:** Files on `/mnt/c/` are slow

**Solution:**

Keep vault on WSL2 filesystem:

```bash
# Move to WSL2 home
cp -r "/mnt/c/Users/You/ObsidianVault" ~/obsidian-vault
cd ~/obsidian-vault
```

Or use Obsidian with WSL2 path:
- Open folder: `\\wsl$\Ubuntu\home\user\obsidian-vault`

---

## Docker Issues

### Container Won't Start

**Error:** `docker-compose up` fails

**Check logs:**

```bash
docker-compose logs -f
```

**Common causes:**

1. **Port conflict:**
   ```bash
   # Change port in docker-compose.yml
   ports:
     - "8081:8080"  # Instead of 8080:8080
   ```

2. **Environment variables missing:**
   ```bash
   # Check .env file exists
   ls docker/.env

   # Verify contents
   cat docker/.env
   ```

3. **Image not built:**
   ```bash
   docker-compose build --no-cache
   docker-compose up -d
   ```

### Permission Issues in Container

**Error:** `Permission denied` inside container

**Solution:**

```bash
# Run as root
docker-compose exec -u root morning-routine bash

# Or rebuild with your user ID
docker-compose build --build-arg UID=$(id -u) --build-arg GID=$(id -g)
```

### gcalcli Not Working in Docker

**Problem:** `gcalcli: command not found` in container

**Check:**

```bash
# Enter container
docker-compose exec morning-routine bash

# Verify installation
which gcalcli
gcalcli --version
```

**Fix:**

```bash
# Rebuild container
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## Workflow Issues

### Routine Doesn't Progress

**Problem:** Workflow stops after first stage

**Cause:** Missing tool permissions or error in command

**Debug:**

1. **Check command files:**
   ```bash
   ls -la .claude/commands/morning-routine/
   ```

2. **Test individual stages:**
   ```bash
   /morning-routine:check-in
   /morning-routine:review-yesterday
   /morning-routine:review-goals
   /morning-routine:schedule-day
   ```

3. **Check for errors:**
   - Look for error messages in Claude Code output
   - Verify all files have correct YAML frontmatter

### Date Command Fails

**Error:** `date: invalid option -- 'v'`

**Cause:** macOS vs Linux date command difference

**Solution:**

In command files, use GNU date format:

```bash
# macOS (BSD date):
date -v-1d +%Y-%m-%d

# Linux (GNU date):
date -d "yesterday" +%Y-%m-%d

# Cross-platform solution - use in files:
date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d
```

### No Daily Files Found

**Error:** `No Events Found` when reviewing yesterday

**Cause:** No daily notes exist yet

**Solution:**

Normal on first run! The system will:
1. Skip review-yesterday (no history)
2. Create first daily note during check-in
3. Start showing patterns after 3 days

### Goal Progress Bar Wrong

**Problem:** Progress shows incorrect percentage

**Cause:** Date format in goal frontmatter

**Fix:**

```yaml
# Correct format (ISO 8601):
start: 2026-01-06
end: 2026-03-06

# Incorrect:
start: Jan 6, 2026
end: 03/06/2026
```

---

## FAQ

### Q: Can I use this without Obsidian?

**A:** Yes! The system uses plain Markdown files. You can:
- Use any text editor
- View in VS Code
- Access via terminal (`cat`, `nano`, etc.)

Obsidian just provides a nice UI for notes.

### Q: Does this work offline?

**A:** Partially:
- ✅ Morning routine works offline
- ✅ Goal tracking works offline
- ✅ Note creation works offline
- ❌ Google Calendar integration requires internet

### Q: Can I sync across devices?

**A:** Yes! Use:
- **Git** - Version control for files
- **Dropbox/Google Drive** - Cloud sync
- **Obsidian Sync** - Official Obsidian sync
- **Syncthing** - Open-source sync

Just sync the entire directory with Daily/, Goals/, and .claude/ folders.

### Q: How do I backup my data?

**A:** All data is in plain Markdown files:

```bash
# Backup to cloud
rsync -av Daily/ Goals/ ~/Dropbox/morning-routine-backup/

# Or use Git
git init
git add Daily/ Goals/
git commit -m "Backup $(date +%Y-%m-%d)"
git push origin main
```

### Q: Can I use a different calendar app?

**A:** Currently supports Google Calendar via gcalcli. To add support for:

**Apple Calendar (macOS):**
```bash
# Use AppleScript in schedule-day.md
osascript -e 'tell application "Calendar"
  make new event at calendar "Work" with properties {summary:"Task"}
end tell'
```

**Outlook:**
- Use Microsoft Graph API
- Or export/import ICS files

**Custom integration:**
- Modify `schedule-day.md`
- Use your calendar's CLI or API

### Q: Does this cost money?

**A:** No! Entirely free:
- ✅ Claude Code - Free
- ✅ gcalcli - Free & open source
- ✅ Google Calendar API - Free (personal use)
- ✅ Obsidian - Free (Sync is paid option)

### Q: How much disk space does this use?

**A:** Minimal:
- Daily notes: ~1KB each
- Goals: ~2KB each
- After 1 year: ~500KB total

### Q: Can multiple people use this on one machine?

**A:** Yes:
- Each user has own home directory
- Each user authenticates gcalcli separately
- Each user has own Daily/Goals folders

Or use Docker with separate containers per user.

### Q: What if I miss a day?

**A:** No problem!
- Just run the routine next day
- Pattern analysis adapts to gaps
- Goal tracking continues
- No data loss

### Q: Can I export my data?

**A:** Yes! Data is plain Markdown:

```bash
# Export to PDF
for file in Daily/*.md; do
  pandoc "$file" -o "${file%.md}.pdf"
done

# Export to HTML
for file in Daily/*.md; do
  pandoc "$file" -o "${file%.md}.html"
done

# Export to JSON (custom script)
python scripts/export-json.py
```

---

## Getting More Help

### Check Logs

```bash
# gcalcli logs
tail -f ~/.gcalcli/debug.log

# Docker logs
docker-compose logs -f

# System logs
journalctl -u morning-routine
```

### Enable Debug Mode

```bash
# Add to .env or export
export GCALCLI_DEBUG=1
export VERBOSE=1

# Run with debug
gcalcli --debug agenda
```

### Report Issues

If you can't resolve an issue:

1. **Search existing issues:** [GitHub Issues](https://github.com/leviceroy/morning-routine-system/issues)
2. **Check discussions:** [GitHub Discussions](https://github.com/leviceroy/morning-routine-system/discussions)
3. **Open new issue with:**
   - OS and version
   - Python version
   - Error messages
   - Steps to reproduce
   - What you've tried

### Community Support

- **GitHub Discussions:** Ask questions, share configs
- **Issue Tracker:** Report bugs, request features

---

## Still Stuck?

If this guide doesn't help:

1. Open an issue on [GitHub](https://github.com/leviceroy/morning-routine-system/issues)
2. Include:
   - Your operating system
   - Python version (`python3 --version`)
   - gcalcli version (`gcalcli --version`)
   - Complete error message
   - Steps you've tried

We'll help you get it working!
