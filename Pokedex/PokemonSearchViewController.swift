//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Steven Patterson on 7/26/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text where searchTerm.characters.count > 0 else {return}
        
        PokemonController.searchPokemon(searchTerm) { (pokemon) in
            guard let pokemon = pokemon else {return}
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.namLabel.text = pokemon.name
                self.idLabel.text = String(pokemon.id) //or you can string interpolate as well ex: self.idLabel.text = "\(pokemon.id)"
                self.abilitiesLabel.text = pokemon.abilities.joinWithSeparator(", ")
            })
        }
    }
}
