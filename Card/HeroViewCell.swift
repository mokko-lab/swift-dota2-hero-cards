//
//  HeroViewCell.swift
//  Card
//
//  Created by Mitesh Shah on 6/8/17.
//  Copyright © 2017 Mokko. All rights reserved.
//

import Foundation
import UIKit

class HeroViewCell : UICollectionViewCell {
    
    @IBOutlet var txtHeroName: UILabel?
    @IBOutlet var imgHeroImage: UIImageView?
    @IBOutlet var txtHeroStrength: UILabel?
    @IBOutlet var txtHeroAgility: UILabel?
    
    public func setHero(hero: Hero) {
        
        self.imgHeroImage?.sd_setImage(with: URL(string: hero.imageUrl))
        self.txtHeroName?.text = hero.name
        self.txtHeroStrength?.text = String(format: "%.0f", hero.strength)
        self.txtHeroAgility?.text = String(format: "%.0f", hero.agility)
        
    }
    
}
