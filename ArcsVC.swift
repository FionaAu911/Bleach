//
//  ArcsVC.swift
//  Bleach
//
//  Created by Fiona Au on 12/1/21.
//

import UIKit
import CoreData

class ArcsVC: UITableViewController {
    
    var arcs: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
    }
    
    // maybe change the purpose of this
    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: showDailyReminder) {
//            let alert = UIAlertController(title: NSLocalizedString("ArcsVCAlertTitle", comment: ""), message: NSLocalizedString("ArcsVCAlertMessage", comment: ""), preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("ArcsVCAlertAction", comment: ""), style: .cancel))
//            self.present(alert, animated: true)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        title = NSLocalizedString("ArcsVCTitle", comment: "")
        navigationItem.title = NSLocalizedString("ArcsVCTitle", comment: "")
        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
//            self.view.backgroundColor = UIColor(named: "ArcsVCbackgroundColor")
            self.tableView.backgroundColor = UIColor.black
            self.tableView.separatorColor = UIColor(named: "yellowish")
        } else {
            overrideUserInterfaceStyle = .light
//            self.view.backgroundColor = UIColor(named: "ArcsVCbackgroundColor")
            self.tableView.backgroundColor = UIColor.systemBlue
            self.tableView.separatorColor = UIColor.systemGray
        }
    }
    
    func deletionAlert(arc: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertMsg = NSLocalizedString("Did you finish", comment: "") + " " + arc + "?"
        let alert = UIAlertController(title: NSLocalizedString("Arc Completion", comment: ""), message: alertMsg, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: NSLocalizedString("Completed", comment: ""), style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)

        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arcs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArcsCell") as? ArcsCell else {
            fatalError("Expected ArcsCell")
        }

        if let item = arcs[indexPath.row] as? Arc {
            cell.update(with: item)
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let entry = arcs[indexPath.row] as? Arc, let name = entry.name {
                deletionAlert(arc: name, completion: { _ in
                    self.deleteItem(arc: entry)
                })
            }
        }
    }
    
    // MARK: - CoreData
    
    func readData() {
        let context = AppDelegate.cdContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Arc")
        do {
            arcs = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested item. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func deleteItem(arc: Arc) {
        let context = AppDelegate.cdContext
        if let _ = arcs.firstIndex(of: arc)  {
            context.perform {
                arc.watched.toggle()
                self.readData()
            }
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not alter information. \(error), \(error.userInfo)")
            }
        }
    }
 
}
