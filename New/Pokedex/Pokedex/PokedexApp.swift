//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 01/06/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    @State var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.startDestination()
                    .navigationDestination(for: Destination.self) { destination in
                        coordinator.viewForDestination(destination)
                    }
            }
            
            .environment(coordinator)
        }
        
    }
}
