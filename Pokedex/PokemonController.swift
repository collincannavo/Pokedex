//
//  PokemonController.swift
//  Pokedex
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {

    static let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")
    
    static func fetchPokemon(with name: String, completion: @escaping (Pokemon?) -> Void) {
        // Create URL
        guard let url = baseURL else { completion(nil); return }
        
        let searchURL = url.appendingPathComponent(name)
        
        // Create the Reqeust
        var request = URLRequest(url: searchURL)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        //Create and resume data Task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            //Handle error and data 
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
        }
            
        guard let data = data,
            let serializedDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any]
            else { completion(nil); return }
        
        // Create a Pokemon
            
        var pokemon = Pokemon(dictionary: serializedDictionary)
            
            guard let endpoint = pokemon?.imageEndpoint else { completion(nil); return }
            
            self.fetchImage(imageEndpoint: endpoint, completion: { (image) in
                pokemon?.image = image
                
                //Completion(pokemon)
                completion(pokemon)
                
            })
            
    }
        dataTask.resume()

    }
    
    static func fetchImage(imageEndpoint: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: imageEndpoint) else { completion(nil); return }
        
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data,
                    let image = UIImage(data: data)
                    else { completion(nil); return }
                
                completion(image)
        }
        
        dataTask.resume()
    }
}






















