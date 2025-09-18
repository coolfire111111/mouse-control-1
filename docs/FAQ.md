# ❓ Frequently Asked Questions (FAQ)

The most commonly asked questions about Mouse Control and their answers.

## 📋 Table of Contents

- [General Questions](#general-questions)
- [Installation](#installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Security](#security)
- [Development](#development)

## 🤔 General Questions

### What is Mouse Control?
Mouse Control is an app that lets you use your mouse's forward/back buttons to switch between full-screen apps on macOS. It replaces the three-finger swipe gesture.

### Is it free?
Yes, it's completely free and open source. You can support it with donations.

### Which macOS versions does it support?
It works on macOS 13.0 (Ventura) and later.

### Which mouse models are supported?
Most mouse models are supported:
- ✅ Logitech (MX Master, MX Anywhere, G series)
- ✅ Microsoft (Surface Mouse, IntelliMouse)
- ✅ Razer (DeathAdder, Basilisk)
- ✅ SteelSeries (Rival, Sensei)
- ✅ Generic USB/Bluetooth mice

### Does it support Apple Magic Mouse?
Magic Mouse doesn't have physical forward/back buttons, so it's not supported. However, you can use third-party apps to convert touch gestures to button presses.

## 🔧 Installation

### How do I install it?
The easiest way is to download the DMG file:
1. Download from [GitHub Releases](https://github.com/coolfire111111/mouse-control/releases)
2. Open the DMG file
3. Drag MouseControl.app to Applications

### Can I install it via Homebrew?
Not yet, but it will be added to Homebrew soon.

### I'm getting a Gatekeeper warning
This is normal. For unsigned apps, you can:
- Go to System Preferences → Security & Privacy and click "Open Anyway"
- Or use Terminal: `sudo xattr -rd com.apple.quarantine /Applications/MouseControl.app`

### What is Accessibility permission?
It's a macOS permission that Mouse Control needs to capture mouse button events. It's only used to listen to mouse events.

## 🖱️ Usage

### Mouse buttons aren't working
Checklist:
1. ✅ Is Accessibility permission granted?
2. ✅ Is the app running? (icon in system tray?)
3. ✅ Do you have full-screen apps?
4. ✅ Are mouse drivers installed?

### Which buttons do what?
- **Forward button (Button 3)**: Switch to next Space/full-screen app
- **Back button (Button 4)**: Switch to previous Space/full-screen app

### It only works in some apps
This is normal. Space switching only works:
- Between full-screen apps
- Between different Spaces

Use Cmd+Tab for regular windowed apps.

### How does it work with multiple monitors?
If you have separate Spaces for each monitor, it switches between the active monitor's Spaces.

### How do I set up auto-start?
Go to System Preferences → Users & Groups → Login Items and add MouseControl.

## 🐞 Troubleshooting

### App won't open
```bash
# Run from Terminal to see error messages
/Applications/MouseControl.app/Contents/MacOS/MouseControl

# Check permissions
ls -la /Applications/MouseControl.app/Contents/MacOS/MouseControl
```

### System is slowing down
Mouse Control is very lightweight. Slowdown might be from another cause:
```bash
# Check CPU usage
top -p $(pgrep MouseControl)
```

### Events aren't being triggered
Run in debug mode:
```bash
/Applications/MouseControl.app/Contents/MacOS/MouseControl
```
You should see messages when you press mouse buttons.

### Working in wrong direction
This depends on your mouse model. We can change the button mapping in the code.

### Doesn't work in certain apps
Some apps (especially games) capture mouse events exclusively. This is normal behavior.

## 🔒 Security

### Is it safe?
Yes, completely safe:
- ✅ Open source code
- ✅ Only needs Accessibility permission
- ✅ No internet connection
- ✅ No data collection
- ✅ Local processing only

### What data does it access?
Only mouse button events. No keyboard, screen content, or other data.

### Is it a keylogger?
No, it only listens to mouse buttons, not keyboard keys.

### Why does it need Accessibility permission?
macOS requires Accessibility permission to capture mouse events. This is Apple's security standard.

## 💻 Development

### Where is the source code?
Fully available on [GitHub](https://github.com/coolfire111111/mouse-control).

### Can I contribute?
Absolutely! Read the [CONTRIBUTING.md](../CONTRIBUTING.md) file.

### Can I suggest new features?
Of course! Create a "Feature Request" in [GitHub Issues](https://github.com/coolfire111111/mouse-control/issues).

### What technologies are used?
- **Language**: Swift 5.9+
- **Framework**: Cocoa, Carbon
- **Build**: Swift Package Manager
- **Platform**: macOS 13.0+

### How to test?
```bash
git clone https://github.com/coolfire111111/mouse-control.git
cd mouse-control
swift build
swift run MouseControl
```

## 🎯 Use Cases

### Developer
- Code editor full-screen
- Terminal full-screen  
- Browser full-screen
- Quick switching with mouse buttons

### Designer
- Figma/Sketch full-screen
- Photoshop full-screen
- Reference browser full-screen
- Quick comparisons

### Video Editor
- Final Cut Pro full-screen
- Media browser full-screen
- Timeline full-screen
- Smooth workflow

### Student
- Study notes full-screen
- PDF reader full-screen
- Web research full-screen
- Distraction-free work

## 📊 Performance

### System resource usage
- **RAM**: ~5MB
- **CPU**: 0.1% (when idle)
- **Disk**: 36KB
- **Battery**: Negligible impact

### Benchmarking
```bash
# Memory usage
ps aux | grep MouseControl | grep -v grep

# CPU usage
top -l 1 | grep MouseControl
```

## 🔄 Updates

### How to update?
No auto-update. Manual process:
1. Check [GitHub Releases](https://github.com/coolfire111111/mouse-control/releases)
2. Download new version
3. Install over old version

### Update notifications
Not available currently, but may be added in future versions.

### Where's the changelog?
All changes are listed in [CHANGELOG.md](../CHANGELOG.md).

## 📞 Support

### I need more help
- 🐞 **Bugs**: [GitHub Issues](https://github.com/username/mouse-control/issues)
- 💬 **Questions**: [GitHub Discussions](https://github.com/username/mouse-control/discussions)  
- 📧 **Email**: support@example.com
- 🐦 **Twitter**: @username

### I can't find my answer
You can ask questions in GitHub Discussions. The community and developers will help.

---

**Help improve this FAQ by contributing!**