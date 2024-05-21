//
//  FeedResponse.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import Foundation

class FeedResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonFeedNameResponse]
    
    class PokemonFeedNameResponse: Decodable {
        let name: String
        let url: String
    }
}
