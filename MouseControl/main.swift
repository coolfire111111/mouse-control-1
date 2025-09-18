import Cocoa
import Carbon

class MouseControlApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var eventTap: CFMachPort?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupMouseEventTap()
        print("🖱️ Mouse Control başlatıldı! Fare ileri/geri tuşları artık pencere geçişi yapacak.")
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "computermouse", accessibilityDescription: "Mouse Control")
            button.toolTip = "Mouse Control - Fare tuşları ile pencere geçişi"
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Mouse Control Aktif", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Çıkış", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
    
    private func setupMouseEventTap() {
        // Accessibility izni kontrolü
        let trusted = kAXTrustedCheckOptionPrompt.takeUnretainedValue()
        let privOptions = [trusted: true] as CFDictionary
        let accessEnabled = AXIsProcessTrustedWithOptions(privOptions)
        
        if !accessEnabled {
            let alert = NSAlert()
            alert.messageText = "Accessibility İzni Gerekli"
            alert.informativeText = "Mouse Control'ün çalışması için Accessibility izni gerekli. Sistem Tercihleri > Güvenlik ve Gizlilik > Gizlilik > Accessibility'den bu uygulamayı ekleyin."
            alert.alertStyle = .warning
            alert.runModal()
            return
        }
        
        // Mouse event tap oluştur
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
            print("❌ Event tap oluşturulamadı!")
            return
        }
        
        // Event tap'i run loop'a ekle
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        
        print("✅ Mouse event tap başarıyla kuruldu!")
    }
    
    static func handleMouseEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
        
        if type == .otherMouseDown {
            let buttonNumber = event.getIntegerValueField(.mouseEventButtonNumber)
            
            // Farklı olası button numaralarını test et
            switch buttonNumber {
            case 3: // İleri tuşu - Sonraki tam ekran uygulamaya geç
                print("🖱️ İleri tuşuna basıldı - Sonraki tam ekran uygulamaya geçiliyor")
                triggerSpaceSwitcher(forward: false) // Düzeltildi
                return nil // Event'i tüket
                
            case 4: // Geri tuşu - Önceki tam ekran uygulamaya geç
                print("🖱️ Geri tuşuna basıldı - Önceki tam ekran uygulamaya geçiliyor")
                triggerSpaceSwitcher(forward: true) // Düzeltildi
                return nil // Event'i tüket
                
            default:
                break
            }
        }
        
        return Unmanaged.passRetained(event)
    }
    
    static func triggerSpaceSwitcher(forward: Bool) {
        // AppleScript ile Mission Control Space geçişi
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
            // Fallback: CGEvent ile dene
            triggerSpaceSwitcherCGEvent(forward: forward)
        }
    }
    
    static func triggerSpaceSwitcherCGEvent(forward: Bool) {
        // Control+Sol Ok (önceki space) veya Control+Sağ Ok (sonraki space) kombinasyonunu simüle et
        let source = CGEventSource(stateID: .hidSystemState)
        
        // Control tuşunu bas (59 = Control)
        let controlDown = CGEvent(keyboardEventSource: source, virtualKey: 59, keyDown: true)
        
        // Ok tuşunu bas (Sol: 123, Sağ: 124)
        let arrowKey = forward ? 124 : 123
        let arrowDown = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(arrowKey), keyDown: true)
        let arrowUp = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(arrowKey), keyDown: false)
        
        // Control tuşunu bırak
        let controlUp = CGEvent(keyboardEventSource: source, virtualKey: 59, keyDown: false)
        
        // Modifier flagleri ayarla
        controlDown?.flags = .maskControl
        arrowDown?.flags = .maskControl
        arrowUp?.flags = .maskControl
        controlUp?.flags = []
        
        // Event'leri gönder
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

// Ana uygulama
let app = NSApplication.shared
let delegate = MouseControlApp()
app.delegate = delegate

// Dock'ta görünmemesi için
app.setActivationPolicy(.accessory)

app.run() 