//
//  backgroundsModel.swift
//  Bleach
//
//  Created by Fiona Au on 12/5/21.
//

import UIKit

class backgroundsModel {
    
    let backgrounds_dark = [UIImage(named: "huecoMundo"), UIImage(named: "karakuraTown"), UIImage(named: "lasNoches")]
    let backgrounds_light = [UIImage(named: "seireitei"), UIImage(named: "rukongai"), UIImage(named: "uraharaShop")]
    var backgroundsIndex_dark = 0
    var backgroundsIndex_light = 0
    
    func nextBackground_light() -> UIImage {
        if (backgroundsIndex_light == 2) {
            backgroundsIndex_light = 0
            return backgrounds_light[backgroundsIndex_light]!
        }
        backgroundsIndex_light += 1
        return backgrounds_light[backgroundsIndex_light]!
    }
    
    func nextBackground_dark() -> UIImage {
        if (backgroundsIndex_dark == 2) {
            backgroundsIndex_dark = 0
            return backgrounds_dark[backgroundsIndex_dark]!
        }
        backgroundsIndex_dark += 1
        return backgrounds_dark[backgroundsIndex_dark]!

    }
}
