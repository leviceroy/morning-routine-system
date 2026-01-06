# GitHub Repository Setup Guide

Step-by-step guide to publish the Morning Routine System to GitHub.

## Prerequisites

- GitHub account
- Git installed locally
- Repository created on GitHub: `morning-routine-system`

## Step 1: Initialize Local Repository

```bash
cd /mnt/g/My\ Drive/OBSIDIAN\ Vault/levicroutinevault/my-morning-routine-installation

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Morning Routine System v1.0.0

- Complete installation package
- Docker support
- Cross-platform compatibility (macOS, Linux, WSL2)
- Google Calendar integration via gcalcli
- Comprehensive documentation
- Automated setup scripts"
```

## Step 2: Create GitHub Repository

1. Go to [GitHub](https://github.com/)
2. Click "New Repository"
3. Repository name: `morning-routine-system`
4. Description: "Automated morning routine workflow for Claude Code with Google Calendar integration"
5. Choose: **Public**
6. **Do NOT** initialize with README (we already have one)
7. Click "Create repository"

## Step 3: Connect and Push

```bash
# Add remote
git remote add origin git@github.com:leviceroy/morning-routine-system.git

# Verify remote
git remote -v

# Push to GitHub
git push -u origin main
```

If using HTTPS instead of SSH:
```bash
git remote add origin https://github.com/leviceroy/morning-routine-system.git
git push -u origin main
```

## Step 4: Configure Repository Settings

### Topics

Add topics to help users discover your repository:

1. Go to repository page
2. Click "About" → ⚙️
3. Add topics:
   - `morning-routine`
   - `productivity`
   - `claude-code`
   - `gcalcli`
   - `google-calendar`
   - `obsidian`
   - `workflow`
   - `automation`
   - `time-management`
   - `goal-tracking`

### Description

```
Automated morning routine workflow for Claude Code with Google Calendar integration, goal tracking, and pattern analysis
```

### Website

Link to documentation or demo (if available)

## Step 5: Create Releases

### First Release (v1.0.0)

```bash
# Tag the release
git tag -a v1.0.0 -m "Version 1.0.0 - Initial Release

Features:
- Morning check-in workflow
- 3-day pattern analysis
- Goal tracking with progress bars
- Google Calendar integration
- Cross-platform support (macOS, Linux, WSL2, Docker)
- Automated setup scripts
- Comprehensive documentation"

# Push tags
git push origin --tags
```

### GitHub Release Page

1. Go to repository → Releases → "Draft a new release"
2. Choose tag: `v1.0.0`
3. Release title: "Morning Routine System v1.0.0 - Initial Release"
4. Description:

```markdown
# Morning Routine System v1.0.0

First stable release of the Morning Routine System!

## 🎉 Features

- **Automated Workflow** - Sequential morning routine stages
- **Pattern Analysis** - 3-day trend identification
- **Goal Tracking** - Progress bars and contextual questions
- **Calendar Integration** - Automatic Google Calendar event creation
- **Cross-Platform** - macOS, Linux, WSL2, Docker support
- **Easy Setup** - Automated installation script

## 📦 Installation

```bash
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system
./scripts/setup.sh
```

## 📖 Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [Quick Start](docs/QUICKSTART.md)
- [Configuration](docs/CONFIGURATION.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## 🐛 Known Issues

None at this time

## 🙏 Credits

Thanks to all contributors and testers!
```

5. Click "Publish release"

## Step 6: Add Shields/Badges

Update README.md with build status, version, etc. (already included):

```markdown
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/github/v/release/leviceroy/morning-routine-system)](https://github.com/leviceroy/morning-routine-system/releases)
[![Google Calendar](https://img.shields.io/badge/Google-Calendar-green.svg)](https://calendar.google.com)
```

## Step 7: Enable GitHub Features

### Discussions

1. Go to Settings → Features
2. Enable "Discussions"
3. Create categories:
   - Q&A
   - Ideas
   - Show and Tell (custom configs)
   - General

### Issues

1. Go to Issues → Labels
2. Add custom labels:
   - `good-first-issue`
   - `help-wanted`
   - `enhancement`
   - `documentation`
   - `question`

### Projects (Optional)

Create a project board to track development:
- TODO
- In Progress
- Done

## Step 8: Add GitHub Actions (Optional)

Create `.github/workflows/test.yml`:

```yaml
name: Test Installation

on: [push, pull_request]

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
        python-version: ['3.8', '3.9', '3.10', '3.11']

    steps:
    - uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install gcalcli

    - name: Test gcalcli installation
      run: gcalcli --version

    - name: Verify file structure
      run: |
        test -f README.md
        test -f LICENSE
        test -d .claude/commands/morning-routine
        test -d docs
```

## Step 9: Create Wiki (Optional)

1. Enable Wiki in repository settings
2. Create pages:
   - Home
   - Installation
   - Configuration
   - Examples
   - FAQ

## Step 10: Social Media & Promotion

### Share on Platforms

- Reddit: r/productivity, r/selfimprovement
- Hacker News
- Twitter/X
- LinkedIn
- Dev.to

### Example Post

```
🌅 Just released Morning Routine System v1.0!

An automated morning workflow for Claude Code that helps you:
- Review yesterday's patterns
- Track goals with progress bars
- Schedule your day automatically
- Integrate with Google Calendar

Free & open source!

https://github.com/leviceroy/morning-routine-system

#productivity #automation #opensource
```

## Maintenance Checklist

### Regular Tasks

- [ ] Respond to issues within 48 hours
- [ ] Review pull requests weekly
- [ ] Update documentation as needed
- [ ] Tag new releases for significant updates
- [ ] Monitor discussions

### Version Updates

When releasing new versions:

```bash
# Update version in README, scripts, etc.
# Commit changes
git add .
git commit -m "Bump version to vX.Y.Z"

# Create tag
git tag -a vX.Y.Z -m "Version X.Y.Z - Description"

# Push
git push origin main --tags
```

## Repository Structure

Final structure should look like:

```
morning-routine-system/
├── .claude/
│   ├── commands/
│   │   └── morning-routine/
│   │       ├── main.md
│   │       ├── check-in.md
│   │       ├── review-yesterday.md
│   │       ├── review-goals.md
│   │       └── schedule-day.md
│   └── templates/
│       ├── morning-checkin.md
│       └── goal.md
├── .github/
│   └── workflows/
│       └── test.yml
├── Daily/
│   └── .gitkeep
├── Goals/
│   └── .gitkeep
├── Notes/
│   └── .gitkeep
├── docker/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── .env.example
│   └── entrypoint.sh
├── docs/
│   ├── INSTALLATION.md
│   ├── QUICKSTART.md
│   ├── CONFIGURATION.md
│   └── TROUBLESHOOTING.md
├── examples/
│   ├── README.md
│   └── minimal-config.md
├── scripts/
│   └── setup.sh
├── .gitignore
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Security

### Protect Sensitive Data

Ensure `.gitignore` includes:
- `.env` files
- OAuth credentials
- Personal daily notes
- Personal goals

### Secrets

Never commit:
- Google API keys
- OAuth tokens
- Personal calendar names
- Email addresses

## Support

After publishing:

1. **Monitor issues** - Respond quickly
2. **Accept PRs** - Review contributions
3. **Update docs** - Keep documentation current
4. **Tag releases** - Version your releases
5. **Engage community** - Respond in discussions

---

## Quick Reference Commands

```bash
# Clone for development
git clone git@github.com:leviceroy/morning-routine-system.git

# Create feature branch
git checkout -b feature/new-feature

# Commit changes
git add .
git commit -m "feat: Add new feature"

# Push changes
git push origin feature/new-feature

# Create release
git tag -a v1.1.0 -m "Version 1.1.0"
git push origin --tags
```

---

**Your Morning Routine System is now on GitHub and ready for the world!** 🚀
