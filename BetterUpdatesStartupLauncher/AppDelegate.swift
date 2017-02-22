//
//  AppDelegate.swift
//  BetterUpdatesStartupLauncher
//
//  Created by Philippe Weidmann on 16.02.17.
//  Copyright © 2017 Philippe Weidmann. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "ch.immortal.BetterUpdates"
        let running           = NSWorkspace.shared().runningApplications
        var alreadyRunning    = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: Notification.Name("killme"), object: mainAppIdentifier)
            NSWorkspace.shared().launchApplication("/Applications/BetterUpdates.app")
        }
        else {
            self.terminate()
        }
    }
    
    func terminate() {
        NSApp.terminate(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

