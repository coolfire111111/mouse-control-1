import Cocoa
import Carbon

class MouseControlApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var eventTap: CFMachPort?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupMouseEventTap()
        print("🖱️ Mouse Control started! Forward/back mouse buttons now switch between spaces.")
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "computermouse", accessibilityDescription: "Mouse Control")
            button.toolTip = "Mouse Control - Switch spaces with mouse buttons"
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Mouse Control Active", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
    
    private func setupMouseEventTap() {
        // Check Accessibility permission
        let trusted = kAXTrustedCheckOptionPrompt.takeUnretainedValue()
        let privOptions = [trusted: true] as CFDictionary
        let accessEnabled = AXIsProcessTrustedWithOptions(privOptions)
        
        if !accessEnabled {
            let alert = NSAlert()
            alert.messageText = "Accessibility Permission Required"
            alert.informativeText = "Mouse Control needs Accessibility permission to work. Please add this app in System Settings > Privacy & Security > Privacy > Accessibility."
            alert.alertStyle = .warning
            alert.runModal()
            return
        }
        
        // Create mouse event tap
        let eventMask = (1 << CGEventType.otherMouseDown.rawValue) | (1 << CGEventType.otherMouseUp.rawValue)
        
        eventTap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(eventMask),
            callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                return MouseControlApp.handleMouseEvent(proxy: proxy, type: type, event: event, refcon: refcon)
            },
            userInfo: Unmanaged.passUnretained(self).toOpaque()
        )
        
        guard let eventTap = eventTap else {
            print("❌ Failed to create event tap!")
            return
        }
        
        // Add event tap to run loop
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        
        print("✅ Mouse event tap successfully created!")
    }
    
    static func handleMouseEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
        
        if type == .otherMouseDown {
            let buttonNumber = event.getIntegerValueField(.mouseEventButtonNumber)
            
            // Test different possible button numbers
            switch buttonNumber {
            case 3: // Forward button - Switch to next full-screen app
                print("🖱️ Forward button pressed - Switching to next full-screen app")
                triggerSpaceSwitcher(forward: false) // Corrected
                return nil // Consume event
                
            case 4: // Back button - Switch to previous full-screen app
                print("🖱️ Back button pressed - Switching to previous full-screen app")
                triggerSpaceSwitcher(forward: true) // Corrected
                return nil // Consume event
                
            default:
                break
            }
        }
        
        return Unmanaged.passRetained(event)
    }
    
    static func triggerSpaceSwitcher(forward: Bool) {
        // Mission Control Space switching with AppleScript
        let appleScript = """
        tell application "System Events"
            key code \(forward ? "124" : "123") using {control down}
        end tell
        """
        
        let task = Process()
        task.launchPath = "/usr/bin/osascript"
        task.arguments = ["-e", appleScript]
        
        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            // Fallback: try with CGEvent
            triggerSpaceSwitcherCGEvent(forward: forward)
        }
    }
    
    static func triggerSpaceSwitcherCGEvent(forward: Bool) {
        // Simulate Control+Left Arrow (previous space) or Control+Right Arrow (next space) combination
        let source = CGEventSource(stateID: .hidSystemState)
        
        // Press Control key (59 = Control)
        let controlDown = CGEvent(keyboardEventSource: source, virtualKey: 59, keyDown: true)
        
        // Press Arrow key (Left: 123, Right: 124)
        let arrowKey = forward ? 124 : 123
        let arrowDown = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(arrowKey), keyDown: true)
        let arrowUp = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(arrowKey), keyDown: false)
        
        // Release Control key
        let controlUp = CGEvent(keyboardEventSource: source, virtualKey: 59, keyDown: false)
        
        // Set modifier flags
        controlDown?.flags = .maskControl
        arrowDown?.flags = .maskControl
        arrowUp?.flags = .maskControl
        controlUp?.flags = []
        
        // Send events
        controlDown?.post(tap: .cghidEventTap)
        usleep(10000) // 10ms
        
        arrowDown?.post(tap: .cghidEventTap)
        usleep(50000) // 50ms
        
        arrowUp?.post(tap: .cghidEventTap)
        usleep(10000) // 10ms
        
        controlUp?.post(tap: .cghidEventTap)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
            CFMachPortInvalidate(eventTap)
        }
    }
}

// Main application
let app = NSApplication.shared
let delegate = MouseControlApp()
app.delegate = delegate

// Hide from Dock
app.setActivationPolicy(.accessory)

app.run() 