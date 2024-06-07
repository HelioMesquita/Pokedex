//
//  DetailView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI

struct DetailView: View {
    
    @State var backgroundColor = Color.clear
    @State var viewModel: DetailViewModelProtocol
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        HStack {
            DetailLeftView(viewModel: viewModel, backgroundColor: $backgroundColor)
            DetailRightView(viewModel: viewModel, backgroundColor: $backgroundColor)
        }.onAppear {
            viewModel.loadDetail()
        }
        .navigationTitle(viewModel.detailPokemon?.name.capitalized ?? "")
    }
    
}

#Preview {
    class PreviewDetailViewModel: DetailViewModelProtocol {
        var detailPokemon: DetailModel? = DetailModel(name: "Pikachu", order: 1, weight: 10, types: [.init(name: "test")], abilities: [.init(name: "test")], stats: [.init(base: 10, name: "test")], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/26.png", height: 10)
        
        func loadDetail() {}
    }
    @State var backgroundColor: Color = .clear
    
    return DetailView(viewModel: PreviewDetailViewModel())
}
