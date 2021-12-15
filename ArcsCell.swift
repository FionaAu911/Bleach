//
//  ArcsCell.swift
//  Bleach
//
//  Created by Fiona Au on 12/1/21.
//

import UIKit
//import CoreData

class ArcsCell: UITableViewCell {
    
    @IBOutlet var arcName: UILabel!
    @IBOutlet var arcEpisodeStart: UILabel!
    @IBOutlet var arcEpisodeEnd: UILabel!
    @IBOutlet var arcWatched: UIImageView!
    
    // localize
    @IBOutlet weak var episodeLabel: UILabel!
    
    func update(with item: Arc) {
//        print("in update function")
         
        episodeLabel?.text = NSLocalizedString("episodeLabel", comment: "")
        
        if let name = item.value(forKey: "name") as? String,
            let epStart = item.value(forKey: "epStart") as? String,
            let epEnd = item.value(forKey: "epEnd") as? String,
            let watched = item.value(forKey: "watched") as? Bool {

            arcName?.text = name
            arcName?.font = UIFont(name: "HiraginoSans-W6", size: 15)
            arcEpisodeStart?.text = epStart
            arcEpisodeStart?.font = UIFont(name: "HiraginoSans-W6", size: 15)
            arcEpisodeEnd?.text = epEnd
            arcEpisodeEnd?.font = UIFont(name: "HiraginoSans-W6", size: 15)
            episodeLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)

            
            if (watched == true) {
                arcWatched.image = UIImage(systemName: "checkmark")
            } else {
                arcWatched.image = UIImage(systemName: "square")
            }
                
           
        }
        
        self.backgroundColor = UIColor(named: "Silver")
        
    }
    
}
