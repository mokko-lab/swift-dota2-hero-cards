//
//  ViewController.swift
//  Card
//
//  Created by Mitesh Shah on 6/8/17.
//  Copyright © 2017 Mokko. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

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

class ViewController: UIViewController {

    @IBOutlet var txtName: UILabel?
    @IBOutlet var txtStrength : UILabel?
    @IBOutlet var txtAgility: UILabel?
    @IBOutlet var imgHeroImage: UIImageView?
    
    var heroes = [Hero]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Import Heroes from JSON.
        readJson()
        pickRandomHero()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "heroes", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                   // print(object)
                    
                    object.forEach({ (node) in
                        
                        print(node);
                        
                        let hero = Hero.init(json: node as! [String : Any])
                        if(hero != nil) {
                            heroes.append(hero!);
                        }
 
                    })
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func applyHero(index : NSInteger) {
        if(heroes.count > index) {
            let hero = heroes[index]
            txtName?.text = hero.name
            txtStrength?.text = String(format: "%.0f", hero.strength)
            txtAgility?.text = String(format: "%.0f", hero.agility)
            
            imgHeroImage?.sd_setImage(with: URL(string: hero.imageUrl))
            
        }
    }
    
    func pickRandomHero(){
        
        if(heroes.count > 0) {
            let rand = Int(arc4random_uniform(UInt32(heroes.count)))
            applyHero(index: rand)
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            pickRandomHero()
        }
    }
    
}

