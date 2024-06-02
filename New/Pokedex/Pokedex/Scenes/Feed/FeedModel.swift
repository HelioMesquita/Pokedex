//
//  FeedModel.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import Foundation

class FeedModel {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    init(count: Int, next: String?, previous: String?, results: [Pokemon]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    struct Pokemon: Hashable, Identifiable, Equatable {
        
        let id = UUID()
        let name: String
        let url: String
        
        init(predictionName: String) {
            self.name = "\(predictionName.split(separator: " ").first!)"
            self.url = "https://pokeapi.co/api/v2/pokemon/" + "\(predictionName.split(separator: " ").last!)/"
        }
        
        init(name: String, url: String) {
            self.name = name
            self.url = url
        }
        
        var imageURL: String {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(String(describing: getId)).png"
        }
        
        var getId: Int {
            var id = url.components(separatedBy: "https://pokeapi.co/api/v2/pokemon/").last ?? ""
            id = String(id.dropLast())
            return Int(id) ?? 0
        }
        
        static func == (lhs: FeedModel.Pokemon, rhs: FeedModel.Pokemon) -> Bool {
            return lhs.id == rhs.id
        }
    }
}
