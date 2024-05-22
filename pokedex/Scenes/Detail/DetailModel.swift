//
//  DetailModel.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import Foundation

class DetailModel {
    let name: String
    let order: Int
    let weight: Double
    let types: [String]
    let abilities: [String]
    let stats: [PokemonStats]
    let image: String
    
    init(name: String, 
         order: Int,
         weight: Double,
         types: [String],
         abilities: [String],
         stats: [PokemonStats],
         image: String) {
        self.name = name
        self.order = order
        self.weight = weight
        self.types = types
        self.abilities = abilities
        self.stats = stats
        self.image = image
    }
    
    class PokemonStats {
        let base: Double
        let name: String
        
        init(base: Double, name: String) {
            self.base = base
            self.name = name
        }
    }
    
}
