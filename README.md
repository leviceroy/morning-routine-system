# Morning Routine System for Claude Code

> A complete automated morning routine workflow that helps you start your day with clarity, focus, and intentionality.

[![Version](https://img.shields.io/badge/version-v1.1-blue.svg)](https://github.com/leviceroy/morning-routine-system/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Google Calendar](https://img.shields.io/badge/Google-Calendar-green.svg)](https://calendar.google.com)

## 🌅 What is This?

The Morning Routine System is an automated workflow that runs inside Claude Code to help you:

- **Review yesterday** - Analyze patterns across the last 3 days with vivid reconstructions
- **Morning check-in** - Quick reflection on mood, energy, sleep, and focus
- **Review goals** - Track progress with contextual questions and progress bars
- **Schedule your day** - Automatically create Google Calendar events with time-blocked Pomodoros
- **Start with clarity** - Begin each day knowing exactly what to do

## ✨ Features

- 🔄 **Automatic workflow progression** - Stages run sequentially without interruption
- 📊 **Pattern analysis** - Identifies trends across multiple days
- 🎯 **Goal tracking** - Progress bars, deadlines, and intelligent questions
- 📅 **Google Calendar integration** - Automatic event creation with gcalcli
- 🌐 **Cross-platform** - Works on macOS, Linux, Windows (WSL2), and Docker
- 📝 **Markdown-based** - All notes stored as plain text in Obsidian
- 🤖 **AI-powered** - Contextual insights and pattern recognition

## 🚀 Quick Start

### Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed
- [Obsidian](https://obsidian.md/) (optional, but recommended for note management)
- Google account for calendar integration
- Python 3.8+ (for gcalcli)

### Installation (5 minutes)

**Option 1: Automated Script (Recommended)**

```bash
# Clone the repository
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system

# Run installation script
./scripts/setup.sh
```

**Option 2: Docker (Easiest)**

```bash
# Pull and run Docker container
docker-compose up -d
```

**Option 3: Manual Installation**

See [INSTALLATION.md](docs/INSTALLATION.md) for detailed step-by-step instructions.

## 📖 Documentation

- **[Installation Guide](docs/INSTALLATION.md)** - Complete setup instructions
- **[Quick Start Guide](docs/QUICKSTART.md)** - Get running in 5 minutes
- **[Configuration](docs/CONFIGURATION.md)** - Customize your routine
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions

## 🎬 Usage

Once installed, simply run:

```bash
/morning-routine:main
```

The workflow will:

1. 📚 **Review Yesterday** (2 min) - Reconstruct yesterday with timestamps, patterns, and insights
2. ☀️ **Morning Check-in** (3 min) - Quick reflection questions (mood, energy, sleep, focus)
3. 🎯 **Review Goals** (5 min) - Progress tracking with contextual questions
4. 📅 **Schedule Day** (3 min) - Time-block your priorities into calendar events
5. ✅ **Complete** - Ready to start your day!

**Total time:** ~15 minutes

## 📂 Directory Structure

```
morning-routine-system/
├── .claude/
│   ├── commands/
│   │   └── morning-routine/      # Workflow command definitions
│   │       ├── main.md            # Orchestrator
│   │       ├── check-in.md        # Morning reflection
│   │       ├── review-yesterday.md # Pattern analysis
│   │       ├── review-goals.md    # Goal tracking
│   │       └── schedule-day.md    # Calendar integration
│   └── templates/
│       ├── morning-checkin.md     # Daily note template
│       └── goal.md                # Goal file template
├── Daily/                         # Daily notes (created automatically)
├── Goals/                         # Goal tracking files
├── docker/                        # Docker configuration
├── scripts/                       # Installation scripts
└── docs/                          # Documentation
```

## 🔧 Configuration

### Google Calendar Setup

The routine integrates with Google Calendar using gcalcli. Setup takes ~5 minutes:

1. Create OAuth credentials in Google Cloud Console
2. Run `gcalcli init --noauth_local_server`
3. Authenticate with your Google account

See [Configuration Guide](docs/CONFIGURATION.md) for details.

### Customization

Edit `.claude/commands/morning-routine/*.md` to customize:
- Reflection questions
- Calendar name
- Time block durations
- Pattern analysis depth

## 🌍 Cross-Platform Support

| Platform | Status | Method |
|----------|--------|--------|
| macOS | ✅ Fully supported | Native or Docker |
| Linux | ✅ Fully supported | Native or Docker |
| WSL2 (Windows) | ✅ Fully supported | Native or Docker |
| Docker | ✅ Fully supported | All platforms |

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
# Fork and clone
git clone https://github.com/leviceroy/morning-routine-system.git
cd morning-routine-system

# Create feature branch
git checkout -b feature/your-feature

# Make changes and test
./scripts/test.sh

# Submit pull request
```

## 📜 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 📋 Changelog

### v1.1 (2026-01-12)

**Fixed:**
- **Calendar events now reliably created** - Schedule-day workflow now MUST execute gcalcli commands (previously could skip calendar creation while only creating markdown file)
- **Full datetime format** - Changed from `HH:MM` to `YYYY-MM-DD HH:MM` for reliable event creation across timezones and dates
- **Verification step added** - Workflow now verifies events appear in Google Calendar after creation

**Updated:**
- `schedule-day.md` - Added CRITICAL/MANDATORY instructions for calendar creation
- `main.md` - Added explicit note about required calendar event creation
- `TROUBLESHOOTING.md` - Added new section for "Schedule-Day Creates File But Skips Calendar Events"
- `CONFIGURATION.md` - Added time format best practices section

### v1.0 (2026-01-06)

- Initial release with full morning routine workflow
- Google Calendar integration via gcalcli
- Goal tracking with progress bars
- Pattern analysis across 3 days
- Cross-platform support (macOS, Linux, WSL2, Docker)

## 🙏 Acknowledgments

- Calendar integration powered by [gcalcli](https://github.com/insanum/gcalcli)
- Designed for use with [Obsidian](https://obsidian.md/)

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/leviceroy/morning-routine-system/issues)
- **Discussions:** [GitHub Discussions](https://github.com/leviceroy/morning-routine-system/discussions)

---

**Made with ❤️ for productivity enthusiasts**
