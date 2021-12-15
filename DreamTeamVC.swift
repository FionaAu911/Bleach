//
//  DreamTeam.swift
//  Bleach
//
//  Created by Fiona Au on 12/3/21.
//

import UIKit
import CoreData

class DreamTeamVC: ViewController {
 
    var team: [NSManagedObject] = []
    var model = TeamBuilderModel()
    
    // localize
    @IBOutlet weak var BuildTeamVCTitle: UILabel!
    @IBOutlet weak var captainLabel: UILabel!
    @IBOutlet weak var liutenantLabel: UILabel!
    @IBOutlet weak var additionalOfficersLabel: UILabel!
    @IBOutlet weak var insigniaLabel: UILabel!
    
    @IBOutlet weak var chosenCaptain: UILabel!
    @IBOutlet weak var chosenLiutenant: UILabel!
    @IBOutlet weak var chosenAddOff1: UILabel!
    @IBOutlet weak var chosenAddOff2: UILabel!
    @IBOutlet weak var insigniaImage: UIImageView!
    @IBOutlet weak var readyForBattleImage: UIImageView!
    @IBOutlet weak var readyForBattleImageBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dreamTeamLabel: UILabel!
    @IBOutlet weak var buildButton: UIButton!
    
    var presentAlert = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BuildTeamVCTitle?.text = NSLocalizedString("DreamTeamVCTitle", comment: "")
        BuildTeamVCTitle?.font = UIFont(name: "HiraginoSans-W6", size: 20)
        captainLabel?.text = NSLocalizedString("captainLabel", comment: "")
        captainLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        liutenantLabel?.text = NSLocalizedString("liutenantLabel", comment: "")
        liutenantLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        additionalOfficersLabel?.text = NSLocalizedString("additionalOfficersLabel", comment: "")
        additionalOfficersLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        insigniaLabel?.text = NSLocalizedString("insigniaLabel", comment: "")
        insigniaLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        buildButton?.setTitle(NSLocalizedString("buildTeamButton", comment: ""), for: .normal)
        buildButton?.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        buildButton?.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        
        if presentAlert == true {
            alertingAlert()
        }
        loadScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: showDailyReminder) {
            let alert = UIAlertController(title: NSLocalizedString("BuildTeamAlertTitle", comment: ""), message: NSLocalizedString("BuildTeamAlertMessage", comment: ""), preferredStyle: .alert)
            let gotIt = UIAlertAction(title:NSLocalizedString("GotIt", comment: ""), style: .cancel, handler: { (action) -> Void in })

            alert.addAction(gotIt)

            alert.popoverPresentationController?.permittedArrowDirections = []
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)

            present(alert, animated: true, completion: nil)
            presentAlert = false
        }
//        if UserDefaults.standard.bool(forKey: showDailyReminder) {
//           let alert = UIAlertController(title: NSLocalizedString("ArcsVCAlertTitle", comment: ""), message: NSLocalizedString("ArcsVCAlertMessage", comment: ""), preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: NSLocalizedString("ArcsVCAlertAction", comment: ""), style: .cancel))
//           self.present(alert, animated: true)
//       }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        title = NSLocalizedString("DreamTeamVCTitle", comment: "")

        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
            readyForBattleImage?.image = UIImage(named: "ready_red")
            dreamTeamLabel.textColor = UIColor(named: "yellowish")
        } else {
            overrideUserInterfaceStyle = .light
            readyForBattleImage?.image = UIImage(named: "ready_blue")
            dreamTeamLabel.textColor = UIColor.systemGray
        }
    }
    
    func loadScreen() {
        self.readyForBattleImage?.alpha = 0.0
        let context = AppDelegate.cdContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do {
            team = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested item. \(error), \(error.userInfo)")
        }
        
        for item in team {
            if let captain = item.value(forKey: "captain") as? String,
               let liutenant = item.value(forKey: "liutenant") as? String,
               let addOfficer1 = item.value(forKey: "additional1") as? String,
               let addOfficer2 = item.value(forKey: "additional2") as? String,
               let insignia = item.value(forKey: "insignia") as? String {
                                
                chosenCaptain?.text = captain
                chosenLiutenant?.text = liutenant
                chosenAddOff1?.text = addOfficer1
                chosenAddOff2?.text = addOfficer2
                insigniaImage?.image = model.insigniaChoice(choice: insignia)
            }
        }
    }
    
    func alertingAlert() -> Void {
//        let alert = UIAlertController(title: NSLocalizedString("BuildTeamAlertTitle", comment: ""), message: NSLocalizedString("BuildTeamAlertMessage", comment: ""), preferredStyle: .alert)
//        let gotIt = UIAlertAction(title:NSLocalizedString("GotIt", comment: ""), style: .cancel, handler: { (action) -> Void in })
//
//        alert.addAction(gotIt)
//
//        alert.popoverPresentationController?.permittedArrowDirections = []
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
//
//        present(alert, animated: true, completion: nil)
//        presentAlert = false
    }
    
    func animateReady(_ show: Bool) -> Void {
        UIView.animate(withDuration: 0.0, animations: {
            self.readyForBattleImage?.alpha = 1.0
        }, completion: { _ in
            let yPos = -self.view.frame.width
            self.readyForBattleImageBottomConstraint?.constant = yPos
            UIView.animate(withDuration: 1.0, animations: {
                print("with duration 1.0")
                self.readyForBattleImageBottomConstraint?.constant = -yPos * 0.8
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.readyForBattleImage?.alpha = 0.0
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.readyForBattleImageBottomConstraint?.constant = yPos
                        self.view.layoutIfNeeded()
                    })
                })
            })
        })
    }
    
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        loadScreen()
        self.viewDidLoad()
        animateReady(true)
    }
    
}
