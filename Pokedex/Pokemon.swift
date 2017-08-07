//
//  Pokemon.swift
//  Pokedex
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon {
    
    private let nameKey = "name"
    private let weightKey = "weight"
    private let idKey = "id"
    private let imageEndpointKey = "front_default"
    
    
    let name: String
    let weight: Int
    let id: Int
    let imageEndpoint: String
    var image: UIImage?
    
    
    init?(dictionary: [String:Any]) {
        guard let name = dictionary[nameKey] as? String,
        let weight = dictionary[weightKey] as? Int,
        let id = dictionary[idKey] as? Int,
        let spritesDictionary = dictionary["sprites"] as? [String:Any],
        let imageEndpoint = spritesDictionary[imageEndpointKey] as? String
            
            else { return nil }
        
        self.name = name
        self.weight = weight
        self.id = id
        self.imageEndpoint = imageEndpoint
        
    }
}
