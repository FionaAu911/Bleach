//
//  File.swift
//  Bleach
//
//  Created by Fiona Au on 12/3/21.
//

import UIKit
import CoreData

class BuildTeamVC: ViewController {
    
    var model = TeamBuilderModel()
        
    @IBOutlet weak var captainPicker: UIPickerView!
    @IBOutlet weak var liutenantPicker: UIPickerView!
    @IBOutlet weak var addOfficer1: UITextField!
    @IBOutlet weak var addOfficer2: UITextField!
    @IBOutlet weak var insigniaImage: UIImageView!
    var insigniaName = ""
    @IBOutlet weak var zangetsuImage: UIImageView!
    @IBOutlet weak var zangetsuFromTheRight: NSLayoutConstraint!
    
    // localize
    @IBOutlet weak var captainLabel: UILabel!
    @IBOutlet weak var liutenantLabel: UILabel!
    @IBOutlet weak var addOff1Label: UILabel!
    @IBOutlet weak var addOff2Label: UILabel!
    @IBOutlet weak var insigniaLabel: UILabel!
    @IBOutlet weak var buildTeamButton: UIButton!
    
    override func viewDidLoad() {
//        print("BuildTeamVC viewDidLoad")
        super.viewDidLoad()
        
        captainLabel?.text = NSLocalizedString("captainLabel_Build", comment: "")
        liutenantLabel?.text = NSLocalizedString("liutenantLabel_Build", comment: "")
        addOff1Label?.text = NSLocalizedString("additionalOfficer1Label", comment: "")
        addOff2Label?.text = NSLocalizedString("additionalOfficer2Label", comment: "")
        insigniaLabel?.text = NSLocalizedString("insigniaLabel", comment: "")
        buildTeamButton?.setTitle(NSLocalizedString("buildTeamButton", comment: ""), for: .normal)
        buildTeamButton?.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        buildTeamButton?.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)
        
        captainPicker.delegate = self
        captainPicker.dataSource = self
        liutenantPicker.delegate = self
        liutenantPicker.dataSource = self
        
        captainPicker.tag = 1
        liutenantPicker.tag = 2
        
        insigniaImage.image = model.insignias[0]
        self.zangetsuImage?.alpha = 0.0
        animateZangetsu(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
            captainLabel?.textColor = UIColor(named: "yellowish")
            liutenantLabel?.textColor = UIColor(named: "yellowish")
            addOff1Label?.textColor = UIColor(named: "yellowish")
            addOff2Label?.textColor = UIColor(named: "yellowish")
            insigniaLabel?.textColor = UIColor(named: "yellowish")
        } else {
            overrideUserInterfaceStyle = .light
            captainLabel?.textColor = UIColor.systemGray
            liutenantLabel?.textColor = UIColor.systemGray
            addOff1Label?.textColor = UIColor.systemGray
            addOff2Label?.textColor = UIColor.systemGray
            insigniaLabel?.textColor = UIColor.systemGray
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // every view has a touchesBegan, touchesEnd
//        view.endEditing(true) // detects that view has received a tap -> then no more editing
//    }
    
    func saveItem(addOfficer1: String, addOfficer2: String) {
        let context = AppDelegate.cdContext
        if let entity = NSEntityDescription.entity(forEntityName: "Team", in: context) {
            let item = NSManagedObject(entity: entity, insertInto: context)
            item.setValue(addOfficer1, forKeyPath: "additional1")
            item.setValue(addOfficer2, forKeyPath: "additional2")
            let captainChoice = captainPicker.selectedRow(inComponent: 0)
            item.setValue(model.captainChoice(choice: captainChoice), forKeyPath: "captain")
            let liutenantChoice = liutenantPicker.selectedRow(inComponent: 0)
            item.setValue(model.liutenantChoice(choice: liutenantChoice), forKeyPath: "liutenant")
            item.setValue(insigniaName, forKeyPath: "insignia")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the item. \(error), \(error.userInfo)")
            }
        }
        self.viewDidLoad()
    }
    
    @IBAction func onBuild(_ sender: Any) {
        if let addOfficer1 = addOfficer1?.text, let addOfficer2 = addOfficer2?.text {
            saveItem(addOfficer1: addOfficer1, addOfficer2: addOfficer2)
        }
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        insigniaImage.image = model.nextInsignia()
        insigniaTransition(view: insigniaImage!, animationOptions: .curveEaseIn)
        insigniaName = model.insigniaName()
    }
    
    func insigniaTransition(view: UIImageView, animationOptions: UIView.AnimationOptions) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func animateZangetsu(_ show: Bool) -> Void {
        UIView.animate(withDuration: 0.0, animations: {
            self.zangetsuImage?.alpha = 1.0
        }, completion: { _ in
            let yPos = show ? -self.view.frame.width : self.view.frame.width
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.zangetsuFromTheRight?.constant = -yPos
                self.view.layoutIfNeeded()
            }, completion: { _ in
//                print("done")
            })
        })
    }
    
}

extension BuildTeamVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return model.captains.count
        case 2:
            return model.liutenants.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return model.captains[row]
        case 2:
            return model.liutenants[row]
        default:
            return "Data not found"
        }
    }
    
}
