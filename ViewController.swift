//
//  ViewController.swift
//  Bleach
//
//  Created by Fiona Au on 12/1/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    var bmodel = backgroundsModel()
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var welcomeBackText: UILabel!
    @IBOutlet weak var welcomeParagraph: UILabel!
    @IBOutlet weak var ichigo: UIImageView!
    var showBackground = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("HomeVCTitle", comment: "")
        welcomeBackText?.text = NSLocalizedString("welcomeBackText", comment: "")
        welcomeBackText?.textColor = UIColor.white
        welcomeBackText?.font = UIFont(name: "HiraginoSans-W6" , size: 30)
        welcomeParagraph?.text = NSLocalizedString("welcomeParagraph", comment: "")
        welcomeParagraph?.textColor = UIColor.white
        welcomeParagraph?.font = UIFont(name: "HiraginoSans-W6" , size: 20)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: Notification.Name("darkModeChanged"), object: nil)
        
        backgroundImage?.image = UIImage(named: "rukongai")
    }
    
    @objc func notificationReceived() {
        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: showDailyReminder) {
       //            let alert = UIAlertController(title: NSLocalizedString("ArcsVCAlertTitle", comment: ""), message: NSLocalizedString("ArcsVCAlertMessage", comment: ""), preferredStyle: .alert)
       //            alert.addAction(UIAlertAction(title: NSLocalizedString("ArcsVCAlertAction", comment: ""), style: .cancel))
       //            self.present(alert, animated: true)
       //        }
        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        
    }
    
    @IBAction func toggleBackground(_ sender: Any) {
        if showBackground == false {
            welcomeBackText?.alpha = 0.0
            welcomeParagraph?.alpha = 0.0
            ichigo?.alpha = 0.0
            showBackground = true
        } else {
            welcomeBackText?.alpha = 1.0
            welcomeParagraph?.alpha = 1.0
            ichigo?.alpha = 1.0
            showBackground = false
        }
    }
    
    @IBAction func onSwipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            backgroundImage?.image = bmodel.nextBackground_light()
            backgroundTransitionLeft(view: backgroundImage!, animationOptions: .curveEaseIn)
        } else if recognizer.direction == .up {
            backgroundImage?.image = bmodel.nextBackground_dark()
            backgroundTransitionUp(view: backgroundImage!, animationOptions: .curveEaseIn)
        }
    }
    
    func backgroundTransitionLeft(view: UIImageView, animationOptions: UIView.AnimationOptions) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func backgroundTransitionUp(view: UIImageView, animationOptions: UIView.AnimationOptions) {
        UIView.transition(with: view, duration: 0.8, options: .transitionCurlUp, animations: nil, completion: nil)
    }

    
}

