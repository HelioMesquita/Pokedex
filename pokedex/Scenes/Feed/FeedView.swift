//
//  FeedView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedView: View {

    @State var viewModel: FeedViewModelProtocol
    weak var coordinator: AppCoordinator?
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let height: CGFloat = 200
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($viewModel.list) { pokemon in
                        FeedPokemonView(pokemon: pokemon.wrappedValue)
                            .onAppear {
                                viewModel.handleNextPage(pokemon: pokemon.wrappedValue)
                            }
                            .onTapGesture {
                                coordinator?.showDetail(pokemon: pokemon.wrappedValue)
                            }
                            .frame(height: height)
                    }
                }
                .padding()
            }.onAppear {
                viewModel.loadPokemons()
            }
        }
    }
}

struct FeedPokemonView: View {
    let pokemon: FeedModel.Pokemon
    
    @State var backgroundColor = Color.clear
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                Spacer()
                WebImage(url: URL(string: pokemon.imageURL))
                    .onSuccess { image, _, _ in
                            if let color = image.averageColor {
                                DispatchQueue.main.async {
                                    backgroundColor = Color(color.withAlphaComponent(0.8))
                                }
                            }
                        }
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipped()
                    .padding(20)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }.clipShape(RoundedRectangle(cornerRadius: 12))
            Text(pokemon.name.capitalized)
                .font(.title2)
        }.clipped()
    }
}

//#Preview(windowStyle: .automatic) {
//    FeedView()
//}





