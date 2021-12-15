//
//  SettingsVC.swift
//  Bleach
//
//  Created by Fiona Au on 12/3/21.
//

import UIKit

class SettingsVC: ViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var versionNumber: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    // localize
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsLabel?.text = NSLocalizedString("settingsLabel", comment: "")
        settingsLabel?.font = UIFont(name: "HiraginoSans-W6" , size: 20)
        reminderLabel?.text = NSLocalizedString("reminderLabel", comment: "")
        reminderLabel?.font = UIFont(name: "HiraginoSans-W6" , size: 15)
        darkModeLabel?.text = NSLocalizedString("darkModeLabel", comment: "")
        darkModeLabel?.font = UIFont(name: "HiraginoSans-W6" , size: 15)
        appName?.text = NSLocalizedString("appName", comment: "")
        appName?.font = UIFont(name: "HiraginoSans-W6" , size: 12)
        versionNumber?.text = NSLocalizedString("version", comment: "")
        versionNumber?.font = UIFont(name: "HiraginoSans-W6" , size: 12)
        copyrightLabel?.text = NSLocalizedString("copyright", comment: "")
        copyrightLabel?.font = UIFont(name: "HiraginoSans-W6" , size: 12)

        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
            reminderSwitch.thumbTintColor = UIColor.black
            reminderSwitch.onTintColor = UIColor(named: "hollowRed")
            darkModeSwitch.thumbTintColor = UIColor.black
            darkModeSwitch.onTintColor = UIColor(named: "hollowRed")
        } else {
            overrideUserInterfaceStyle = .light
            reminderSwitch.thumbTintColor = UIColor.lightGray
            reminderSwitch.onTintColor = UIColor.link
            darkModeSwitch.thumbTintColor = UIColor.lightGray
            darkModeSwitch.onTintColor = UIColor.link
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reminderSwitch.isOn = defaults.bool(forKey: showDailyReminder)
        darkModeSwitch.isOn = defaults.bool(forKey: darkMode)
    }
    
    @IBAction func onReminderSwitch(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: showDailyReminder)
    }
    
    @IBAction func onDarkModeSwitch(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: darkMode)
        viewDidLoad()
        
        NotificationCenter.default.post(name: Notification.Name("darkModeChanged"), object: nil)
    }
    
    
}
