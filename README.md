# 🖱️ Mouse Control for macOS

**Use your mouse's forward/back buttons to switch between full-screen apps on macOS!**

[![GitHub release](https://img.shields.io/github/release/usecoolfire111111rname/mouse-control.svg)](https://github.com/coolfire111111/mouse-control/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org/)

**🎯 Problem:** Your new mouse's macro buttons only do forward/back, but you love using macOS's three-finger swipe gesture.

**✅ Solution:** Mouse Control maps your mouse buttons to Mission Control's Space switching feature!

![Demo](assets/demo.gif)

## ✨ Features

- 🖱️ **Mouse Forward Button** → Switch to next full-screen app/Space
- 🖱️ **Mouse Back Button** → Switch to previous full-screen app/Space  
- 🎯 **Runs in System Tray** (invisible in Dock)
- ⚡ **Lightweight & secure** (only 36KB!)
- 🔒 **Privacy-focused** - no data collection
- 🚀 **Open source** and free

## 📦 Installation

### Option 1: DMG File (Recommended)

1. [Download MouseControl-1.0.dmg](./MouseControl-1.0.dmg)
2. Double-click `MouseControl-X.X.dmg`
3. Drag `MouseControl.app` to Applications folder
4. Launch MouseControl from Applications

### Option 2: Homebrew

```bash
brew install --cask mouse-control
```

### Option 3: Build from Source

```bash
git clone https://github.com/coolfire111111/mouse-control.git
cd mouse-control
./create_app.sh
```

## 🚀 Usage

1. **Launch the app** - Mouse icon will appear in system tray
2. **Grant Accessibility permission** - Will be prompted automatically
3. **Create full-screen apps** - Safari, VS Code, etc. (press F11)
4. **Use mouse buttons** - Forward/back buttons to switch between them!

### First Setup - Accessibility Permission

When first launched, the app will request Accessibility permission:

1. System Settings → Privacy & Security → Privacy → Accessibility
2. Find MouseControl in the list and enable it
3. Restart the application

## 🔧 Technical Details

- **Platform**: macOS 13.0+
- **Language**: Swift 5.9+
- **Framework**: Cocoa, Carbon
- **Size**: ~36KB
- **Permissions**: Only Accessibility (to capture mouse events)

## 🤝 Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

### Development

```bash
# Clone the project
git clone https://github.com/coolfire111111/mouse-control.git
cd mouse-control

# No dependencies to install
# Build for development
swift build

# Run for testing  
swift run MouseControl
```

## 💝 Support

If this project is useful to you, consider supporting its continued development:

[![GitHub Sponsors](https://img.shields.io/badge/GitHub-Sponsors-pink.svg)](https://github.com/sponsors/coolfire111111)


**Your donations will be used for:**
- 🔧 Developing new features
- 🐛 Fixing bugs  
- 📱 Supporting more mouse models
- 📚 Improving documentation

## 🛠️ Troubleshooting

### Mouse Buttons Not Working
- Ensure Accessibility permission is granted
- Check that mouse drivers are installed
- Run the app from Terminal to see debug messages

### App Won't Start
- Verify macOS version is 13.0+
- If you get a Gatekeeper warning: System Preferences → Security & Privacy → "Open Anyway"

For more help, visit the [Issues](https://github.com/coolfire111111/mouse-control/issues) page.

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Apple for macOS and Swift
- All contributors
- Everyone who supports this project

---

**⭐ If this project helped you, please give it a star!**

Made with ❤️ for the global community 🌍