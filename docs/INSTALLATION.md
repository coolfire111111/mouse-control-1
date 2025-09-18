# 📦 Installation Guide

Different ways to install Mouse Control on your macOS system.

## 🎯 System Requirements

- **macOS**: 13.0 (Ventura) or later
- **Processor**: Intel or Apple Silicon
- **Storage**: 50MB free space
- **Permissions**: Accessibility

## 📥 Installation Options

### Option 1: DMG File (Recommended) 

The easiest and safest method:

1. **Download**: [Get the latest release from GitHub](https://github.com/coolfire111111/mouse-control/releases/latest)
2. **Open**: Double-click `MouseControl-X.X.dmg`
3. **Install**: Drag `MouseControl.app` to Applications folder
4. **Launch**: Start MouseControl from Applications

### Option 2: Homebrew

For Terminal users:

```bash
# Add Homebrew cask (not available yet)
brew tap username/mouse-control
brew install --cask mouse-control

# Launch
open -a MouseControl
```

### Option 3: Build from Source

For developers:

```bash
# Clone the project
git clone https://github.com/coolfire111111/mouse-control.git
cd mouse-control

# Build and install
./create_app.sh

# Launch
open MouseControl.app
```

## 🔒 First Setup - Permissions

### Accessibility Permission

The app will request permission when first launched:

1. **Automatic Dialog**: System will automatically open settings
2. **Manual Path**: 
   - System Settings → Privacy & Security → Privacy → Accessibility
   - Find MouseControl and enable it
3. **Restart**: Quit and relaunch the app

### Gatekeeper Warning

If you get an unsigned app warning:

```bash
# Run from Terminal
sudo xattr -rd com.apple.quarantine /Applications/MouseControl.app

# Or choose "Open Anyway" from System Settings
```

## ✅ Installation Verification

Verify the installation was successful:

### 1. App Launch
```bash
# Test from Terminal
open -a MouseControl

# Or double-click from Applications folder
```

### 2. System Tray Check
- Mouse icon should appear in top-right corner
- Clicking the icon should open a menu

### 3. Mouse Button Test
```bash
# Run in debug mode from Terminal
/Applications/MouseControl.app/Contents/MacOS/MouseControl
```

When you press mouse buttons, you should see messages:
```
🖱️ Forward button pressed - Switching to next full-screen app
🖱️ Back button pressed - Switching to previous full-screen app
```

## 🔄 Auto-Start Setup

To launch automatically at startup:

### Method 1: System Settings
1. System Settings → General → Login Items
2. Click the "+" button
3. Select MouseControl.app

### Method 2: Terminal
```bash
# Create Launch Agent
mkdir -p ~/Library/LaunchAgents

cat > ~/Library/LaunchAgents/com.mousecontrol.app.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.mousecontrol.app</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Applications/MouseControl.app/Contents/MacOS/MouseControl</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

# Enable it
launchctl load ~/Library/LaunchAgents/com.mousecontrol.app.plist
```

## 🗑️ Uninstallation

To completely remove the app:

### 1. Stop the App
```bash
# Find and stop the running process
pkill MouseControl

# Or choose "Quit" from system tray
```

### 2. Delete Files
```bash
# Main application
rm -rf /Applications/MouseControl.app

# Launch Agent (if created)
rm ~/Library/LaunchAgents/com.mousecontrol.app.plist
launchctl unload ~/Library/LaunchAgents/com.mousecontrol.app.plist

# Preferences (none currently, but future versions might have)
rm -rf ~/Library/Preferences/com.mousecontrol.app.plist
```

### 3. Clean Up Permissions
1. System Settings → Privacy & Security → Privacy → Accessibility
2. Remove MouseControl from the list

## 🐞 Troubleshooting

### App Won't Start

**Symptom**: MouseControl won't open
**Solution**:
```bash
# See error messages from Terminal
/Applications/MouseControl.app/Contents/MacOS/MouseControl

# Check permissions
ls -la /Applications/MouseControl.app/Contents/MacOS/MouseControl

# Grant execution permission
chmod +x /Applications/MouseControl.app/Contents/MacOS/MouseControl
```

### Mouse Buttons Not Working

**Symptom**: Pressing buttons does nothing
**Solution**:
1. Check Accessibility permission
2. Reinstall mouse drivers
3. Restart macOS

### No System Tray Icon

**Symptom**: No mouse icon in menu bar
**Solution**:
1. Ensure there's enough space in menu bar
2. Restart the application
3. Toggle macOS Dark/Light mode

### Performance Issues

**Symptom**: System slowing down
**Solution**:
```bash
# Check CPU usage
top -p $(pgrep MouseControl)

# Check memory usage
ps aux | grep MouseControl
```

For installation issues:

- 🐞 **Bug Reports**: [GitHub Issues](https://github.com/coolfire111111/mouse-control/issues)
- 💬 **Questions**: [GitHub Discussions](https://github.com/coolfire111111/mouse-control/discussions)

## 📊 System Status

To check system status after installation:

```bash
# Mouse Control status
pgrep -f MouseControl && echo "✅ Running" || echo "❌ Not running"

# Accessibility permission
sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db \
"SELECT allowed FROM access WHERE service='kTCCServiceAccessibility' AND client LIKE '%MouseControl%'"

# System resources
ps aux | grep MouseControl | grep -v grep
```

---

**Last Updated**: 2024-01-XX