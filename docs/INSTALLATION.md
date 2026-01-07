# Installation Guide

Complete step-by-step installation instructions for the Morning Routine System.

## Table of Contents

- [System Requirements](#system-requirements)
- [Installation Methods](#installation-methods)
  - [Method 1: Automated Script (Recommended)](#method-1-automated-script-recommended)
  - [Method 2: Docker Setup](#method-2-docker-setup)
  - [Method 3: Manual Installation](#method-3-manual-installation)
- [Google Calendar Setup](#google-calendar-setup)
- [Verification](#verification)

---

## System Requirements

### Minimum Requirements

- **Operating System:** macOS 10.15+, Linux (Ubuntu 20.04+), Windows 10+ (with WSL2)
- **Python:** 3.8 or higher
- **Memory:** 512MB RAM
- **Disk Space:** 100MB free space
- **Internet:** Required for Google Calendar API

### Required Software

1. **Claude Code CLI** - [Installation instructions](https://claude.ai/code)
2. **Python 3.8+** - Check version: `python3 --version`
3. **pip** - Python package manager: `pip3 --version`
4. **Git** - Version control: `git --version`

### Optional Software

- **Obsidian** - For note management ([Download](https://obsidian.md/))
- **Docker** - For containerized deployment ([Download](https://www.docker.com/))

---

## Installation Methods

### Method 1: Automated Script (Recommended)

**Time:** 5-10 minutes | **Difficulty:** Easy

This method uses an automated script to set up everything for you.

#### Step 1: Clone Repository

```bash
# Clone the repository
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system
```

#### Step 2: Run Setup Script

```bash
# Make script executable
chmod +x scripts/setup.sh

# Run installation
./scripts/setup.sh
```

The script will:
- ✅ Check system requirements
- ✅ Install Python dependencies (gcalcli)
- ✅ Create directory structure
- ✅ Copy workflow files
- ✅ Set up configuration

#### Step 3: Authenticate Google Calendar

```bash
# Activate virtual environment
source ~/gcalcli-venv/bin/activate

# Initialize gcalcli
gcalcli init --noauth_local_server
```

**What to do:**
1. Enter your Client ID (from Google Cloud Console)
2. Enter your Client Secret
3. Open the URL shown in your browser
4. Authorize the application
5. Copy the authorization code back to terminal

#### Step 4: Configure Calendar Name

```bash
# List your calendars
gcalcli list

# Edit configuration to set your calendar name
nano .claude/commands/morning-routine/schedule-day.md
```

Find the line with `--calendar "YOUR_CALENDAR_NAME"` and replace with your actual calendar name.

#### Step 5: Test Installation

```bash
# Start Claude Code
claude

# Run morning routine
/morning-routine:main
```

**Done!** ✅ Your morning routine is ready to use.

---

### Method 2: Docker Setup

**Time:** 3-5 minutes | **Difficulty:** Easy

Use Docker for a completely isolated, portable installation.

#### Prerequisites

- Docker installed ([Download](https://www.docker.com/get-started))
- Docker Compose installed

#### Step 1: Clone Repository

```bash
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system
```

#### Step 2: Configure Environment

```bash
# Copy example environment file
cp docker/.env.example docker/.env

# Edit environment variables
nano docker/.env
```

Set these variables:
```env
GOOGLE_CLIENT_ID=your_client_id_here
GOOGLE_CLIENT_SECRET=your_client_secret_here
CALENDAR_NAME=Your Calendar Name
TIMEZONE=America/New_York
```

#### Step 3: Build and Run

```bash
# Build and start container
docker-compose up -d

# Check container status
docker-compose ps
```

#### Step 4: Access Container

```bash
# Enter container shell
docker-compose exec morning-routine bash

# Run morning routine inside container
claude
/morning-routine:main
```

#### Docker Management Commands

```bash
# Stop container
docker-compose stop

# Start container
docker-compose start

# View logs
docker-compose logs -f

# Rebuild container
docker-compose up -d --build

# Remove container
docker-compose down
```

---

### Method 3: Manual Installation

**Time:** 15-20 minutes | **Difficulty:** Intermediate

For users who want full control over the installation process.

#### Step 1: Install Python Dependencies

**On macOS/Linux:**
```bash
# Install Python 3 (if not already installed)
# macOS:
brew install python3

# Ubuntu/Debian:
sudo apt update && sudo apt install -y python3 python3-pip python3-venv

# Create virtual environment
python3 -m venv ~/gcalcli-venv

# Activate virtual environment
source ~/gcalcli-venv/bin/activate

# Install gcalcli
pip install gcalcli
```

**On Windows (WSL2):**
```bash
# Install Python 3
sudo apt update && sudo apt install -y python3 python3-pip python3-venv

# Create virtual environment in home directory (not on Windows filesystem)
cd ~
python3 -m venv gcalcli-venv

# Activate virtual environment
source ~/gcalcli-venv/bin/activate

# Install gcalcli
pip install gcalcli
```

#### Step 2: Clone Repository

```bash
# Clone to your preferred location
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system
```

#### Step 3: Set Up Directory Structure

```bash
# Create directories
mkdir -p Daily Goals Notes

# Copy Claude Code configuration
cp -r .claude ~/.claude-morning-routine
```

**Or integrate into existing Obsidian vault:**

```bash
# Navigate to your Obsidian vault
cd /path/to/your/obsidian/vault

# Copy morning routine files
cp -r /path/to/morning-routine-system/.claude/commands/morning-routine .claude/commands/
cp -r /path/to/morning-routine-system/.claude/templates .claude/
```

#### Step 4: Configure Workflow Files

Edit calendar name in `schedule-day.md`:

```bash
# Open file
nano .claude/commands/morning-routine/schedule-day.md

# Find and replace "YOUR_CALENDAR_NAME" with your actual calendar name
# Save and exit (Ctrl+X, Y, Enter)
```

#### Step 5: Authenticate Google Calendar

```bash
# Activate virtual environment
source ~/gcalcli-venv/bin/activate

# Initialize gcalcli
gcalcli init --noauth_local_server
```

Follow the authentication prompts (see Method 1, Step 3 for details).

#### Step 6: Verify Installation

```bash
# Test gcalcli
gcalcli list
gcalcli agenda

# Test morning routine
claude
/morning-routine:main
```

---

## Google Calendar Setup

### Step 1: Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Click "Create Project" or select existing project
3. Enter project name: "Morning Routine System"
4. Click "Create"

### Step 2: Enable Google Calendar API

1. In Cloud Console, go to "APIs & Services" > "Library"
2. Search for "Google Calendar API"
3. Click on the result
4. Click "Enable"

### Step 3: Create OAuth Credentials

1. Go to "APIs & Services" > "Credentials"
2. Click "Create Credentials" > "OAuth client ID"
3. If prompted, configure OAuth consent screen:
   - Choose "External" (for personal Gmail) or "Internal" (for Workspace)
   - Fill in application name: "Morning Routine System"
   - Add your email as developer contact
   - Click "Save and Continue"
   - Skip scopes (click "Save and Continue")
   - Add yourself as test user (for External type)
   - Click "Save and Continue"
4. Back to "Create OAuth client ID":
   - Application type: "Desktop app"
   - Name: "Morning Routine CLI"
   - Click "Create"
5. **Download credentials:**
   - You'll see Client ID and Client Secret
   - **Save these securely** - you'll need them for authentication

### Step 4: Authenticate gcalcli

See installation method steps above for authentication process.

### Common Issues

**"Access blocked: This app isn't verified"**
- Solution: Add yourself as a test user in OAuth consent screen

**"localhost connection refused" (WSL2)**
- Solution: Use `--noauth_local_server` flag

**"Calendar not found"**
- Solution: Run `gcalcli list` to see exact calendar names (case-sensitive)

---

## Verification

After installation, verify everything works:

### 1. Check gcalcli

```bash
source ~/gcalcli-venv/bin/activate
gcalcli list
```

**Expected output:** List of your Google calendars

### 2. Check Claude Code

```bash
claude
/help
```

**Expected output:** Claude Code help menu

### 3. Test Morning Routine

```bash
/morning-routine:check-in
```

**Expected output:** Morning reflection questions

### 4. Test Calendar Integration

```bash
source ~/gcalcli-venv/bin/activate
gcalcli add --calendar "Your Calendar" --title "Test" --when "16:00" --duration 25 --noprompt
gcalcli agenda
```

**Expected output:** Test event appears in agenda

### 5. Verify File Structure

```bash
ls -la .claude/commands/morning-routine/
```

**Expected files:**
- main.md
- check-in.md
- review-yesterday.md
- review-goals.md
- schedule-day.md

---

## Next Steps

✅ Installation complete! Now:

1. **Read the [Quick Start Guide](QUICKSTART.md)** to run your first morning routine
2. **Customize settings** in [Configuration Guide](CONFIGURATION.md)
3. **Create your first goal** using the goal template
4. **Run your morning routine** tomorrow: `/morning-routine:main`

---

## Troubleshooting

If you encounter issues, see the [Troubleshooting Guide](TROUBLESHOOTING.md) or open an issue on [GitHub](https://github.com/leviceroy/morning-routine-system/issues).
