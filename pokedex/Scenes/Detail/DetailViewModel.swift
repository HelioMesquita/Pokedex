//
//  DetailViewModel.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import Foundation

protocol DetailViewModelProtocol {
    func loadDetail()
}

@Observable
class DetailViewModel: DetailViewModelProtocol {
    
    let pokemon: FeedModel.Pokemon
    let service: ServiceProtocol
    
    init(pokemon: FeedModel.Pokemon, service: ServiceProtocol = Service()) {
        self.service = service
        self.pokemon = pokemon
    }
    
    func loadDetail() {
        Task { @MainActor in
            do {
                let pokemon = try await service.execute(DetailRequest(id: pokemon.getId), builder: DetailBuilder())
                print(pokemon)
            } catch {
                print("Error when loading pokemons. Code: \(error.localizedDescription)")
            }
        }
    }
    
}

