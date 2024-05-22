//
//  DetailView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI
import Charts
import SDWebImageSwiftUI

struct DetailView: View {
    
    @State var backgroundColor = Color.red
    @State var viewModel: DetailViewModelProtocol
    weak var coordinator: AppCoordinator?
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    WebImage(url: URL(string: viewModel.detailPokemon?.image ?? ""))
                        .onSuccess { image, _, _ in
                            if let averageColor = AverageColorUtility.getAverageColor(for: image, side: .bottom) {
                                backgroundColor = Color(averageColor)
                            }
                        }
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipped()
                        .padding(20)
                }
            }
            VStack {
                Chart {
                    
                }
            }
        }.onAppear {
            viewModel.loadDetail()
        }
    }
}

//#Preview {
//    DetailView()
//}

