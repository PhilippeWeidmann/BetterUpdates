//
//  AppDelegate.swift
//  BetterUpdates
//
//  Created by Philippe Weidmann on 15.02.17.
//  Copyright © 2017 Philippe Weidmann. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {

    var main: NSWindowController!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let userNotificationCenter = NSUserNotificationCenter.default
        userNotificationCenter.delegate=self
        

        
        //startup launch code
        let launcherURL = Bundle.main.bundleURL.appendingPathComponent("Contents/Library/LoginItems/BetterUpdatesStartupLauncher.app")
        
        LSRegisterURL(launcherURL as CFURL, true)
        let launcherAppIdentifier = "ch.immortal.BetterUpdatesStartupLauncher"
        
        var startedAtLogin = false
        for app in NSWorkspace.shared().runningApplications{
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }

        if startedAtLogin {
            DistributedNotificationCenter.default().post(name: Notification.Name("killme"), object: Bundle.main.bundleIdentifier)
            
        }
        else {
            main = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "MainWindow") as! NSWindowController
            let mainVc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as! ViewController
            main.window?.contentViewController = mainVc
            main.window?.makeKeyAndOrderFront(nil)
        }

        performCheck()

    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSApplication.shared().mainWindow?.close()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    func canUpdate() -> Bool{
        let defaults = UserDefaults.standard
        
        let frequency:Int
        
        if let _ = defaults.object(forKey: "frequency") {
            frequency=defaults.integer(forKey: "frequency")
        }
        else{
            frequency=0
        }
        
        if let _ = defaults.object(forKey: "lastcheck") {
            let lastCheck = Date(timeIntervalSinceNow: defaults.double(forKey: "lastcheck"))
            let userCalendar = Calendar.current
            
            let requestedComponents: Set<Calendar.Component> = [
                .month,
                .day,
                .hour
            ]
            
            let lastCheckComponents = userCalendar.dateComponents(requestedComponents, from: lastCheck)
            let today = userCalendar.dateComponents(requestedComponents, from: Date())

            if((frequency==0 || frequency==1 || frequency==2) && lastCheckComponents.month!>today.month!){
                return true
            }
            else if((frequency==0 || frequency==1) && lastCheckComponents.day!>today.day!){
                return true
            }
            else if((frequency==0) && lastCheckComponents.hour!>today.hour!){
                return true
            }
            else {
             return false
            }
        }
        else{
            return true
        }
    }

    func performCheck(){
        if (canUpdate()) {
            getUpdates()
        }
        else {
            Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(performCheck), userInfo: nil, repeats: false)
        }
    }
    

    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        switch notification._alternateActionIndex {
        case 0:
            Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(sendScheduledNotification(timer:)), userInfo: notification.userInfo, repeats: false)
            break
        case 1:
            Timer.scheduledTimer(timeInterval: 86400, target: self, selector: #selector(sendScheduledNotification(timer:)), userInfo: notification.userInfo, repeats: false)
            break
        default:
            break
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDismissAlert notification: NSUserNotification) {
        let itemID=notification.userInfo!["itemIdentifier"] as! NSNumber;
        _ = download(itemID.uint64Value)
    }
    
    func sendScheduledNotification(timer: Timer) {
        let userInfo = timer.userInfo as! [String: Any]
        sendNotificationFor(app: userInfo["appName"] as! String, bundleID: userInfo["bundleID"] as! String, itemIdentifier: userInfo["itemIdentifier"] as! NSNumber)
        
    }

    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
    }
    
    
    func getUpdates(){
        let defaults = UserDefaults.standard
        
        defaults.setValue(Date().timeIntervalSinceReferenceDate, forKey: "lastcheck")

        let updateController = CKUpdateController.shared()
        let updates = updateController?.availableUpdates()
        let softwareMap = CKSoftwareMap.shared()
        for update in updates! {
            if let installed = softwareMap.product(forBundleIdentifier: update.bundleID) {
                sendNotificationFor(app: installed.appName,bundleID:update.bundleID,itemIdentifier: update.itemIdentifier)
            } else {
                print("\(update.itemIdentifier) \(update.title) (unknown -> \(update.bundleVersion))")
            }
        }

    }
    
    func sendNotificationFor(app appName:String, bundleID:String, itemIdentifier:NSNumber){
        var userInfo = [String: Any]()
        userInfo["appName"] = appName
        userInfo["bundleID"] = bundleID
        userInfo["itemIdentifier"] = itemIdentifier

        
        
        let notification = NSUserNotification()
        notification.title = "Mise à jour disponible"
        notification.informativeText = "Souhaitez-vous mettre à jour "+appName+"?"
        notification.hasActionButton=true
        notification.actionButtonTitle="Plus Tard"
        notification.otherButtonTitle="Installer"
        
        notification.userInfo=userInfo
        //private
        if let path = NSWorkspace().absolutePathForApplication(withBundleIdentifier: bundleID){
            notification._identityImage=NSWorkspace().icon(forFile: path)
            notification._identityImageHasBorder=false
        }
        
        notification._alwaysShowAlternateActionMenu=true
        notification.setValue(["Dans une heure","Demain"], forKey: "_alternateActionButtonTitles")
        notification.setValue(true, forKey: "_alwaysShowAlternateActionMenu");
        
        
        NSUserNotificationCenter.default.deliver(notification)

    }
}

