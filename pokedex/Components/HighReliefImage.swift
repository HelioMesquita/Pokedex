//
//  HighReliefImage.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 28/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HighReliefImage: View {
    
    let image: String
    @Binding var backgroundColor: Color
    
    var body: some View {
        ZStack {
            Spacer()
            WebImage(url: URL(string: image))
                .onSuccess { image, _, _ in
                    guard let color = image.averageColor else { return }
                    DispatchQueue.main.async {
                        backgroundColor = Color(color.withAlphaComponent(0.8))
                    }
                }
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .clipped()
                .padding(.top, 10)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
    
}

#Preview(windowStyle: .automatic) {
    @State var backgroundColor: Color = Color.clear
    HighReliefImage(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png", backgroundColor: $backgroundColor)
}
