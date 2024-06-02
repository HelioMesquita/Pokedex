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
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HighReliefImage(image: viewModel.detailPokemon?.image ?? "", backgroundColor: $backgroundColor)
                if let pokemonName = viewModel.detailPokemon?.name.capitalized {
                    Model3D(named: pokemonName) { model in
                            model.resizable()
    //                    model.clipped()
    //                    model.padding(.top, 10)
                    } placeholder: {
                        ProgressView()
                            .hidden()
                    }
                     .frame(width: 200)
                    .aspectRatio(1.0, contentMode: .fit)
//                   
                    
                }
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

//#Preview {
//    DetailLeftView()
//}

struct VolumeView: View {
    var body: some View {
        Model3D(named: "Blastoise") { model in
                model.resizable()
//                    model.clipped()
//                    model.padding(.top, 10)
        } placeholder: {
            ProgressView()
                .hidden()
        }
         .frame(width: 200)
        .aspectRatio(1.0, contentMode: .fit)
    }
}
