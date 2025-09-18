# 🤝 Contributing Guide

Thank you for contributing to Mouse Control! This guide explains how you can help make this project better.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Environment](#development-environment)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## 📜 Code of Conduct

Everyone participating in this project must:
- ✅ Be respectful and constructive
- ✅ Be open to different opinions  
- ✅ Be willing to learn
- ❌ Not discriminate
- ❌ Not use offensive language

## 🚀 How Can I Contribute?

### 🐛 Bug Reports

If you found a bug:

1. Check the [Issues](https://github.com/coolfire111111/mouse-control/issues) page
2. If no similar issue exists, create a new one
3. Include the following information:
   - macOS version
   - Mouse model
   - When the error occurs
   - Step-by-step reproduction
   - Expected vs actual behavior

### 💡 Feature Requests

If you want a new feature:

1. Create a "Feature Request" in [Issues](https://github.com/coolfire111111/mouse-control/issues)
2. Explain why this feature is needed
3. Detail how it should work
4. Add mockups or examples if possible

### 🔧 Code Contributions

To contribute code:

1. Fork the project
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit (`git commit -m 'Add amazing feature'`)
5. Push your branch (`git push origin feature/amazing-feature`)
6. Create a Pull Request

## 🛠️ Development Environment

### Requirements

- macOS 13.0+
- Xcode 15.0+ (Swift 5.9+)
- Git

### Setup

```bash
# Clone the project
git clone https://github.com/coolfire111111/mouse-control.git
cd mouse-control

# Build for testing
swift build

# Run
swift run MouseControl
```

### Project Structure

```
mouse-control/
├── Sources/
│   └── main.swift          # Main application code
├── MouseControl/
│   ├── Info.plist         # macOS app information
│   └── Assets.xcassets/   # Icons and assets
├── Package.swift          # Swift Package Manager
├── README.md             # Project description
└── LICENSE              # MIT License
```

## 📝 Pull Request Process

### Pre-PR Checklist

- [ ] Code follows Swift standards
- [ ] New features are tested
- [ ] README updated (if needed)
- [ ] Commit messages are clear
- [ ] Focused on a single topic

### PR Template

```markdown
## 📋 Description

What changed in this PR?

## 🔧 Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## ✅ Testing

- [ ] Tested on macOS 13.0
- [ ] Tested on macOS 14.0
- [ ] Tested with different mouse models

## 📸 Screenshots

(Add screenshots if applicable)
```

## 🐞 Issue Reporting

### Bug Report Template

```markdown
**🐛 Bug Description**
Brief description of the bug.

**📋 Reproduction Steps**
1. Go to '...'
2. Click '....'
3. See error

**✅ Expected Behavior**
What should have happened?

**❌ Actual Behavior**
What actually happened?

**💻 Environment**
- macOS: [e.g. 14.0]
- Mouse: [e.g. Logitech MX Master 3]
- App Version: [e.g. 1.0.0]

**📸 Screenshots**
Add if available.
```

### Feature Request Template

```markdown
**💡 Feature Description**
Description of the requested feature.

**❓ Why Is This Needed?**
What problem will this feature solve?

**🔧 How Should It Work?**
How do you want this feature to work?

**📋 Use Cases**
When would you use this feature?

**📸 Mockup/Examples**
Add mockups, drawings, or examples from other apps if available.
```

## 🏷️ Commit Message Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Type examples:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Example:**
```
feat(mouse): add support for Logitech MX series

- Add button mapping for MX Master 3
- Update compatibility list
- Add debug logging for new devices

Closes #42
```

## 🎯 Code Standards

### Swift Style Guide

- 4 spaces indentation
- Camel case variable names
- Descriptive function names
- Comments in English
- Maximum 100 characters per line

### Example:

```swift
// ✅ Good
func triggerSpaceSwitch(forward: Bool) {
    // Trigger space switching command
    let direction = forward ? "right" : "left"
    executeAppleScript(direction: direction)
}

// ❌ Bad
func tss(f: Bool) {
    let d = f ? "r" : "l"
    eas(d: d)
}
```
For questions:

- 🐞 **Bugs/Features**: [GitHub Issues](https://github.com/coolfire111111/mouse-control/issues)
- 💬 **General Questions**: [GitHub Discussions](https://github.com/coolfire111111/mouse-control/discussions)

## 🙏 Thank You

We welcome all kinds of contributions:

- Code review
- Bug reports
- Feature suggestions
- Documentation
- Translation
- Testing
- Donations

Your contributions make Mouse Control better! 🚀