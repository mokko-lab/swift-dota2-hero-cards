//
//  Hero.swift
//  Card
//
//  Created by Mitesh Shah on 6/8/17.
//  Copyright © 2017 Mokko. All rights reserved.
//

import Foundation

struct Hero {
    
    var id:Double
    var name:String
    var strength:Double
    var agility:Double
    var imageUrl:String
    
    
    init?(json: [String: Any]) {
        
        guard let id = json["id"] as? Double,
            let name = json["localized_name"] as? String,
            let strength = json["base_str"] as? Double,
            let agility = json["base_agi"] as? Double,
            let imageUrl = json["img"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.strength = strength
        self.agility = agility
        self.imageUrl = String(format: "%@%@", "http://cdn.dota2.com", imageUrl)
    }
}
