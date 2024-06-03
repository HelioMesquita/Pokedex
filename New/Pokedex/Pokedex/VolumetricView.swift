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
        Model3D(url: url!) { model in
            model.resizable()
        } placeholder: {
            ProgressView()
        }
//        .frame(width: 200)
        .aspectRatio(1.0, contentMode: .fit)
    }
}

//#Preview {
//    VolumetricView()
//}
