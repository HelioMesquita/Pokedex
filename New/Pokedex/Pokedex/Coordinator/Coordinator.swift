//
//  AppCoordinator.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case feed
    case detail(FeedModel.Pokemon)
}

@Observable class Coordinator {
    var path: NavigationPath
    
    init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }
    
    func startDestination() -> some View {
        let viewModel = FeedViewModel()
        return FeedView(viewModel: viewModel)
    }
        
    func showDetail(pokemon: FeedModel.Pokemon) {
        path.append(Destination.detail(pokemon))
    }
    
    @ViewBuilder func viewForDestination(_ destination: Destination) -> some View {
        switch destination {
        case .feed:
            let viewModel = FeedViewModel()
            FeedView(viewModel: viewModel)
        case .detail(let pokemon):
            let viewModel = DetailViewModel(pokemon: pokemon)
            DetailView(viewModel: viewModel)
        }
    }

}
