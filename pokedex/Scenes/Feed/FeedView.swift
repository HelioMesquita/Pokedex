//
//  FeedView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI

struct FeedView: View {

    @State var viewModel: FeedViewModelProtocol
    weak var coordinator: AppCoordinator?
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 350)),
    ]
    let height: CGFloat = 200
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach($viewModel.list) { pokemon in
                        FeedPokemonCell(pokemon: pokemon)
                            .onAppear {
                                viewModel.handleNextPage(pokemon: pokemon.wrappedValue)
                            }
                            .onTapGesture {
                                coordinator?.showDetail(pokemon: pokemon.wrappedValue)
                            }
                            .frame(height: height)
                            .shadow(color: .black, radius: 1)
                    }
                }
                .padding()
            }.onAppear {
                viewModel.loadPokemons()
            }
        }
    }
}

//#Preview(windowStyle: .automatic) {
//    FeedView()
//}
