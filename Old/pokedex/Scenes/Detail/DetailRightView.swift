//
//  DetailRightView.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 28/05/24.
//

import Charts
import SwiftUI

struct DetailRightView: View {
    
    @State var viewModel: DetailViewModelProtocol
    @Binding var backgroundColor: Color
    let height: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("About")
                .font(.title)
                .padding(10)
            HStack(spacing: 30) {
                VStack {
                    HStack {
                        Text("")
                            .faFreeRegular(size: 26)
                        Text(viewModel.detailPokemon?.getWeight ?? "")
                            .font(.title2)
                    }.padding(.bottom, 5)
                        .frame(height: height)
                    Text("Weight")
                        .font(.title3)
                }
                VStack {
                    HStack {
                        Text("📏")
                            .faFreeRegular(size: 26)
                        Text(viewModel.detailPokemon?.getHeight ?? "")
                            .font(.title2)
                    }.padding(.bottom, 5)
                        .frame(height: height)
                    Text("Height")
                        .font(.title3)
                }
                VStack {
                    VStack {
                        ForEach(viewModel.detailPokemon?.abilities ?? []) { ability in
                            Text(ability.name.capitalized)
                                .font(.title2)
                        }
                    }
                    .frame(height: height)
                    Text("Moves")
                        .font(.title3)
                }
            }
            Chart {
                ForEach(viewModel.detailPokemon?.stats ?? []) { stats in
                    BarMark(
                        x: .value("Shape Type", stats.name.capitalized),
                        y: .value("Total Count", stats.base)
                    )
                    .foregroundStyle(backgroundColor)
                    .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
                }
            }
            .padding(20)
            .font(.title2)
        }
    }
}

//#Preview {
//    DetailRightView()
//}
