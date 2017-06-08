//
//  HeroesViewController.swift
//  Card
//
//  Created by Mitesh Shah on 6/8/17.
//  Copyright © 2017 Mokko. All rights reserved.
//

import Foundation

import UIKit
import Foundation
import SDWebImage

class HeroesViewController: UICollectionViewController {
    
    var heroes = [Hero]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readJson()

        collectionView?.dataSource = self;
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let hero = heroes[indexPath.row]
        
        let cell : HeroViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroViewCell
        cell.setHero(hero: hero)
        
        return cell;
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
    
    
}
