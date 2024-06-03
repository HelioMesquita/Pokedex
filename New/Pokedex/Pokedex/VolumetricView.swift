//
//  VolumetricView.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 02/06/24.
//

import SwiftUI
import RealityKit

struct VolumeView: View {
    
    let url: URL?
    
    var body: some View {
        ZStack{
            Model3D(url: url!) { model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }
        .frame(width: 500, height: 500)
    }
}

#Preview(windowStyle: .volumetric) {
    let url = Bundle.main.url(forResource: "Blastoise", withExtension: "usdz")
    return VolumeView(url: url)
}
