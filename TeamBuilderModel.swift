//
//  TeamBuilderModel.swift
//  Bleach
//
//  Created by Fiona Au on 12/3/21.
//

import UIKit

class TeamBuilderModel {
    
    let captains = [NSLocalizedString("Genryusai Yamamoto", comment: ""), NSLocalizedString("Shunsui Kyoraku", comment: ""), NSLocalizedString("Soi-Feng", comment: ""), NSLocalizedString("Rose Otoribashi", comment: ""), NSLocalizedString("Gin Ichimaru", comment: ""), NSLocalizedString("Retsu Yachiru", comment: ""), NSLocalizedString("Isane Kotetsu", comment: ""), NSLocalizedString("Sosuke Aizen", comment: ""), NSLocalizedString("Shinji Hirako", comment: ""), NSLocalizedString("Byakuya, Kuchiki", comment: ""), NSLocalizedString("Sajin Komamura", comment: ""), NSLocalizedString("Tetsuzaemon Iba", comment: ""), NSLocalizedString("Lisa Yadomaru", comment: ""), NSLocalizedString("Kaname Tosen", comment: ""), NSLocalizedString("Kensei Muguruma", comment: ""), NSLocalizedString("Toshiro Hitsugaya", comment: ""), NSLocalizedString("Kenpachi Zaraki", comment: ""), NSLocalizedString("Mayuri Kurotsuchi", comment: ""), NSLocalizedString("Jushiro Ukitake", comment: ""), NSLocalizedString("Rukia Kuchiki", comment: "")]
 
    let liutenants = [NSLocalizedString("Nanao Ise", comment: ""), NSLocalizedString("Genshiro Okikiba", comment: ""), NSLocalizedString("Marechiyo Omaeda", comment: ""), NSLocalizedString("Izuru Kira", comment: ""), NSLocalizedString("Kiyone Kotetsu", comment: ""), NSLocalizedString("Momo Hinamori", comment: ""), NSLocalizedString("Renji Abarai", comment: ""), NSLocalizedString("Atau Rindo", comment: ""), NSLocalizedString("Yuyu Yayahara", comment: ""), NSLocalizedString("Shuhei Hisagi", comment: ""), NSLocalizedString("Mashiro Kuna", comment: ""), NSLocalizedString("Rangiku Matsumoto", comment: ""), NSLocalizedString("Yachiru Kusajishi", comment: ""), NSLocalizedString("Ikkaku Madarame", comment: ""), NSLocalizedString("Akon", comment: ""), NSLocalizedString("Nemu", comment: ""), NSLocalizedString("Sentaro Kotsubaki", comment: "")]
    
    let insignias = [UIImage(named: "squad1"), UIImage(named: "squad2"), UIImage(named: "squad3"), UIImage(named: "squad4"), UIImage(named: "squad5"), UIImage(named: "squad6"), UIImage(named: "squad7"), UIImage(named: "squad8"), UIImage(named: "squad9"), UIImage(named: "squad10"), UIImage(named: "squad11"), UIImage(named: "squad12"), UIImage(named: "squad13")]
    var insigniasIndex = 0
    
    func captainChoice(choice: Int) -> String {
        return captains[choice]
    }
    
    func liutenantChoice(choice: Int) -> String {
        return liutenants[choice]
    }
    
    func insigniaChoice(choice: String) -> UIImage {
//        if (choice.isEmpty) {
//            return UIImage(named: "insigniaPlaceholder")!
//        }
        switch choice {
            case "squad1":
                return UIImage(named: "squad1")!
            case "squad2":
                return UIImage(named: "squad2")!
            case "squad3":
                return UIImage(named: "squad3")!
            case "squad4":
                return UIImage(named: "squad4")!
            case "squad5":
                return UIImage(named: "squad5")!
            case "squad6":
                return UIImage(named: "squad6")!
            case "squad7":
                return UIImage(named: "squad7")!
            case "squad8":
                return UIImage(named: "squad8")!
            case "squad9":
                return UIImage(named: "squad9")!
            case "squad10":
                return UIImage(named: "squad10")!
            case "squad11":
                return UIImage(named: "squad11")!
            case "squad12":
                return UIImage(named: "squad12")!
            case "squad13":
                return UIImage(named: "squad13")!
            default:
                return UIImage(named: "squad1")!
        }
    }
    
    func insigniaName() -> String {
        switch insigniasIndex {
            case 0:
                return "squad1"
            case 1:
                return "squad2"
            case 2:
                return "squad3"
            case 3:
                return "squad4"
            case 4:
                return "squad5"
            case 5:
                return "squad6"
            case 6:
                return "squad7"
            case 7:
                return "squad8"
            case 8:
                return "squad9"
            case 9:
                return "squad10"
            case 10:
                return "squad11"
            case 11:
                return "squad12"
            case 12:
                return "squad13"
            default:
                return "squad1"
        }
    }
    
    func nextInsignia() -> UIImage {
        if insigniasIndex == 12 {
            insigniasIndex = 0
            return insignias[insigniasIndex]!
        }
        insigniasIndex += 1
        return insignias[insigniasIndex]!
    }
    
}
