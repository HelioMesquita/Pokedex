//
//  AppCoordinator.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import UIKit
import SwiftUI

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = FeedViewModel()
        let view = FeedView(viewModel: viewModel, coordinator: self)
        
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Pokédex"
        navigationController.pushViewController(viewController, animated: false)
    }
}
