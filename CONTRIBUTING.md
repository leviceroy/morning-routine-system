# Contributing to Morning Routine System

Thank you for considering contributing to the Morning Routine System! This document provides guidelines for contributing.

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions.

## How to Contribute

### Reporting Bugs

Before creating a bug report, please check if the issue already exists. When creating a bug report, include:

- **Clear title** - Describe the issue concisely
- **Steps to reproduce** - Detailed steps to reproduce the behavior
- **Expected behavior** - What you expected to happen
- **Actual behavior** - What actually happened
- **Environment** - OS, Python version, gcalcli version
- **Screenshots** - If applicable
- **Error messages** - Complete error output

**Template:**

```markdown
## Bug Description
Brief description of the issue

## Steps to Reproduce
1. Step one
2. Step two
3. ...

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., Ubuntu 22.04, macOS 13, WSL2]
- Python version: [e.g., 3.11.2]
- gcalcli version: [e.g., 4.5.1]

## Additional Context
Any other relevant information
```

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Clear description** - What you want to add/change
- **Motivation** - Why this enhancement is useful
- **Examples** - How it would work
- **Alternatives** - Other approaches you've considered

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** - `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly**
5. **Commit with clear messages**
6. **Push to your fork**
7. **Open a pull request**

#### Pull Request Guidelines

- **One feature per PR** - Keep PRs focused
- **Test your changes** - Ensure everything works
- **Update documentation** - Include docs for new features
- **Follow code style** - Match existing patterns
- **Write clear commits** - Descriptive commit messages

#### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting (no code change)
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**

```
feat: Add weekly goal review option

Adds a weekly goal review frequency to complement daily reviews.
Users can now set frequency: "Weekly" in goal frontmatter.

Closes #123
```

```
fix: Correct date format in WSL2

Changes date command from BSD to GNU format for WSL2 compatibility.
Adds fallback for cross-platform support.

Fixes #456
```

## Development Setup

### 1. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/morning-routine-system.git
cd morning-routine-system
```

### 2. Install Dependencies

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

### 3. Create Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 4. Make Changes

Edit files, add features, fix bugs.

### 5. Test Changes

```bash
# Run tests
./scripts/test.sh

# Test manually
source venv/bin/activate
gcalcli --version
# Run morning routine and verify functionality
```

### 6. Commit Changes

```bash
git add .
git commit -m "feat: Add your amazing feature"
```

### 7. Push to Fork

```bash
git push origin feature/your-feature-name
```

### 8. Open Pull Request

Go to GitHub and open a PR from your fork to the main repository.

## Development Guidelines

### Code Style

- **Markdown** - Use consistent formatting
- **Shell scripts** - Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- **Python** - Follow PEP 8
- **Comments** - Explain "why", not "what"

### Documentation

- Update README.md if adding features
- Add entries to relevant docs/ files
- Include examples for new features
- Keep documentation clear and concise

### Testing

Before submitting PR:

- Test on your platform (macOS/Linux/WSL2)
- Verify Google Calendar integration works
- Check all workflow stages complete
- Ensure no regressions in existing features

### File Structure

```
morning-routine-system/
├── .claude/
│   ├── commands/
│   │   └── morning-routine/  # Workflow commands
│   └── templates/             # File templates
├── docker/                    # Docker configuration
├── docs/                      # Documentation
├── examples/                  # Example configurations
├── scripts/                   # Installation scripts
└── tests/                     # Test files
```

## Areas for Contribution

### High Priority

- **Cross-platform testing** - Test on different OS
- **Error handling** - Improve error messages
- **Documentation** - Clarify existing docs
- **Bug fixes** - Fix reported issues

### Medium Priority

- **Integration** - Connect with other tools
- **Customization** - More configuration options
- **UI improvements** - Better output formatting
- **Performance** - Optimize slow operations

### Ideas Welcome

- **New features** - Propose enhancements
- **Integrations** - Connect with other apps
- **Templates** - Create useful templates
- **Themes** - Output themes/styles

## Specific Contribution Opportunities

### Easy (Good First Issues)

- Improve error messages
- Add more examples
- Fix typos in documentation
- Update screenshots
- Add FAQ entries

### Medium

- Add integration with task managers (Todoist, Things)
- Create web dashboard
- Add mobile app support
- Implement habit tracking
- Add data visualization

### Advanced

- AI-powered goal suggestions
- Team collaboration features
- Advanced pattern analysis
- Machine learning for insights
- Calendar conflict resolution

## Review Process

1. **Automated checks** - CI runs tests
2. **Code review** - Maintainer reviews code
3. **Feedback** - Requested changes if needed
4. **Approval** - PR approved
5. **Merge** - Changes merged to main

Expected review time: 1-3 days

## Getting Help

### Questions

- **GitHub Discussions** - Ask questions
- **Issue tracker** - Report problems
- **Documentation** - Check docs first

### Contact

- **GitHub** - [@leviceroy](https://github.com/leviceroy)
- **Issues** - [GitHub Issues](https://github.com/leviceroy/morning-routine-system/issues)

## Recognition

Contributors are:
- Listed in GitHub contributors
- Mentioned in release notes
- Thanked in README.md (significant contributions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to Morning Routine System!** 🙏

Your contributions help make productivity tools accessible to everyone.
