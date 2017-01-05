//
//  Pokemon.swift
//  Pokedex
//
//  Created by Steven Patterson on 7/26/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation

class Pokemon {
    private let kName = "name"
    private let kID = "id"
    private let kAbilities = "abilities"
    
    var name: String
    var id: Int
    var abilities: [String] = []
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
        id = dictionary[kID] as? Int,
            abilitiesArray = dictionary[kAbilities] as? [[String: AnyObject]] else {return nil}
        
        self.name = name
        self.id = id
        
        for abilityDictionary in abilitiesArray {
            guard let ability = abilityDictionary["ability"] as? [String: AnyObject],
                name = ability["name"] as? String else {return}
            
            self.abilities.append(name)
        }
    
    }

}