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
    }
    
}

//#Preview {
//    DetailView()
//}

