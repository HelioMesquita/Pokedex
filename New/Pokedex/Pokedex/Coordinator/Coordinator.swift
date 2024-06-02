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

class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: Destination) -> some View {
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

@Observable class Coordinator {
    var path = NavigationPath()
        
    func showDetail(pokemon: FeedModel.Pokemon) {
        path.append(Destination.detail(pokemon))
    }

}
