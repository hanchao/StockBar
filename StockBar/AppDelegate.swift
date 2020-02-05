
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    let popover = NSPopover()
    let storkMonitor = StorkMonitor()
    var storkMonitorView:ShockMonitorView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // S U P E R important!!! You must provide an initial frame to your custom view class for it to draw in!
        let frame:NSRect = NSRect(x: 0, y: 0, width: 60, height: 22)
        storkMonitorView = ShockMonitorView(frame: frame)
        
        if let button = statusItem.button {
            button.image = NSImage(named:"empty")
            button.addSubview(storkMonitorView!)
            
        }
        
        constructMenu()
        
        storkMonitor.startMonitoring() {
            (bytesIn, bytesOut) -> Void in
            self.storkMonitorView!.stockVaule = bytesIn
            self.storkMonitorView!.stockRate = bytesOut

                // Drawing must take place in the main thread.
                // Therefore we must dispatch commands to the main thread!
                DispatchQueue.main.async { [unowned self] in // unowned self to prevent ARC from holding on to memory
                    self.storkMonitorView!.setNeedsDisplay(NSMakeRect(0, 0, 60, 22))
                }

        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        storkMonitor.stopMonitoring()
    }
    
   @IBAction func quitClicked(sender: NSMenuItem) {
        //NSApplication.shared.terminate(self)
    let myPopup: NSAlert = NSAlert()
     myPopup.messageText = "设置代码"
    myPopup.alertStyle = NSAlert.Style.informational
     myPopup.addButton(withTitle: "好的")
     myPopup.addButton(withTitle: "取消")
    let input = NSTextField()
    input.frame = NSMakeRect(0, 0, 200, 24)
    myPopup.accessoryView = input
    input.stringValue = storkMonitor.stockID;
//    initWithFrame:NSMakeRect(0, 0, 200, 24)];
//    [input setStringValue:defaultValue];
//    [alert setAccessoryView:input];
    
    if( myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn)
     {
        storkMonitor.stockID = input.stringValue
    }
   
   }
    
    func constructMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "设置代码", action: #selector(quitClicked), keyEquivalent: "s"))
        menu.addItem(NSMenuItem(title: "退出", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
}

