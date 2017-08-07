//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let searchTerm = searchBar.text else { print("sorry, I couldn't find anything"); return }
        
        PokemonController.fetchPokemon(with: searchTerm) { (pokemon) in
            guard let pokemon = pokemon else { return }
            
            DispatchQueue.main.async {
                
                self.imageView.image = pokemon.image
                self.nameLabel.text = "Name: \(pokemon.name)"
                self.idLabel.text = "ID: \(pokemon.id)"
                self.weightLabel.text = " Weight: \(pokemon.weight)"

                searchBar.text = ""
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
    }


}
