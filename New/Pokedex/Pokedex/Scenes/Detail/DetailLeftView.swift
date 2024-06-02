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
            if let path = Bundle.main.path(forResource: viewModel.detailPokemon?.name.capitalized ?? "", ofType: "usdz") {
                Button(action: {
                    openWindow(id: "volume")
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
