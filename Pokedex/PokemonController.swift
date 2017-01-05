//
//  PokemonController.swift
//  Pokedex
//
//  Created by Steven Patterson on 7/26/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation

class PokemonController {

    static let baseURL =  "http://pokeapi.co/api/v2/pokemon/"
    
    static func searchPokemon(searchTerm: String, completion: (pokemon: Pokemon?)-> Void) {
        let searchURL = baseURL + searchTerm.lowercaseString
        guard let url = NSURL(string: searchURL) else {
            print("No URL Found")
            completion(pokemon: nil)
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else{
                    print("Error: No Data Found \(error?.localizedDescription)")
                    completion(pokemon: nil)
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject]
                else {
                    print("Error: Unable to Serialize JSON \(responseDataString)")
                    completion(pokemon: nil)
                    return
            }
            
            guard let pokemon = Pokemon(dictionary: jsonDictionary) else {
                print("No Pokemon Found")
                completion(pokemon: nil)
                return
            }
            completion(pokemon: pokemon)
            print("Success: \(pokemon.name)")
        }
    }
}