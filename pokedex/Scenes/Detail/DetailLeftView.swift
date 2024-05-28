//
//  DetailLeftView.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 28/05/24.
//

import SwiftUI

struct DetailLeftView: View {
    
    @State var viewModel: DetailViewModelProtocol
    @Binding var backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 0) {
            HighReliefImage(image: viewModel.detailPokemon?.image ?? "", backgroundColor: $backgroundColor)
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

//#Preview {
//    DetailLeftView()
//}
