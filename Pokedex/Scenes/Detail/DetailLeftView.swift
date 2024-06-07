//
//  DetailLeftView.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 28/05/24.
//

import SwiftUI
import RealityKit

struct DetailLeftView: View {
    
    @State var viewModel: DetailViewModelProtocol
    @Binding var backgroundColor: Color
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack(spacing: 0) {
            HighReliefImage(image: viewModel.detailPokemon?.image ?? "", backgroundColor: $backgroundColor)
            if let url = Bundle.main.url(forResource: viewModel.detailPokemon?.name.capitalized, withExtension: "usdz") {
                Button(action: {
                    openWindow(id: "volume", value: url)
                }, label: {
                    Text("3D Model")
                        .font(.title2)
                        .padding()
                })
                .padding()
            }
            HStack(spacing: 20) {
                ForEach(viewModel.detailPokemon?.types ?? []) { type in
                    Text(type.name.capitalized)
                        .font(.title2)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white, lineWidth: 4)
                        )
                }
            }
            .frame(height: 80)
        }
        .padding()
        .background(
            Color(backgroundColor)
        )
    }
}

#Preview(windowStyle: .automatic) {
    class PreviewDetailViewModel: DetailViewModelProtocol {
        var detailPokemon: DetailModel? = DetailModel(name: "Pikachu", order: 1, weight: 10, types: [.init(name: "test")], abilities: [.init(name: "test")], stats: [.init(base: 10, name: "test")], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/26.png", height: 10)
        
        func loadDetail() {}
    }
    @State var backgroundColor: Color = .clear

    return DetailLeftView(viewModel: PreviewDetailViewModel(), backgroundColor: $backgroundColor)
}
