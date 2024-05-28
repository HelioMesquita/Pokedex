//
//  FeedPokemonCell.swift
//  Pokedex
//
//  Created by Hélio Mesquita on 28/05/24.
//

import SwiftUI

struct FeedPokemonCell: View {
    
    @Binding var pokemon: FeedModel.Pokemon
    @State var backgroundColor: Color = Color.clear
    
    var body: some View {
        VStack {
            HighReliefImage(image: pokemon.imageURL, backgroundColor: $backgroundColor)
            Text("\(pokemon.name.capitalized) #\(pokemon.getId)")
                .font(.title2)
                .padding(.bottom, 10)
        }.clipped()
            .frame(maxWidth: .infinity)
            .background(
                Color(backgroundColor)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

//#Preview {
//    FeedPokemonCell()
//}
