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
        
        WindowGroup(id: "volume") {
            VolumeView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.3, height: 0.3, depth: 0.3, in: .meters)
    }
}
