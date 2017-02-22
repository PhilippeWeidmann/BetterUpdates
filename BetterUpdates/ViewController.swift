//
//  ViewController.swift
//  BetterUpdates
//
//  Created by Philippe Weidmann on 15.02.17.
//  Copyright © 2017 Philippe Weidmann. All rights reserved.
//

import Cocoa
import ServiceManagement

class ViewController: NSViewController {

    @IBOutlet weak var runAtStartupCheckBox: NSButton!
    @IBOutlet weak var frequencyComboBox: NSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
    }

    override var representedObject: Any? {
        didSet {
            loadDefaults()
        }
    }

    @IBAction func runAtStartup(_ sender: NSButton) {
        let launcherAppIdentifier = "ch.immortal.BetterUpdatesStartupLauncher"
        let enabled = (runAtStartupCheckBox.state == 1)
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, enabled)
        saveDefaults()
    }

    @IBAction func updateFrequencyChanged(_ sender: NSComboBox) {
        saveDefaults()
    }
    
    func loadDefaults(){
        let defaults = UserDefaults.standard
        
        if let _ = defaults.object(forKey: "startuplaunch") {
            runAtStartupCheckBox.state = defaults.integer(forKey: "startuplaunch")
        }
        else{
            runAtStartupCheckBox.state=1;
        }
        if let _ = defaults.object(forKey: "frequency") {
            frequencyComboBox.selectItem(at: defaults.integer(forKey: "frequency"))
        }
        else{
            frequencyComboBox.selectItem(at: 0)
        }
    }
    
    func saveDefaults(){
        let defaults = UserDefaults.standard
        
        defaults.setValue(runAtStartupCheckBox.state, forKey: "startuplaunch")
        defaults.setValue(frequencyComboBox.indexOfSelectedItem, forKey: "frequency")

        defaults.synchronize()
    }
    @IBAction func donateButtonClicked(_ sender: Any) {
        NSWorkspace.shared().open(URL(string: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KWQ3SBDQRCHTG")!)
    }

}

