//
//  DetailView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI

struct DetailView: View {
    
    @State var viewModel: DetailViewModelProtocol
    weak var coordinator: AppCoordinator?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.loadDetail()
        }
    }
}

//#Preview {
//    DetailView()
//}

