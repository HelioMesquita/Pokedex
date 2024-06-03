//
//  FeedView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI
import PhotosUI
import Vision

struct FeedView: View {
    

    @State var whatIsThatPokemon: PhotosPickerItem?
    @State var viewModel: FeedViewModelProtocol
    @Environment(Coordinator.self) private var coordinator
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 350)),
    ]
    let height: CGFloat = 200
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach($viewModel.list) { pokemon in
                        FeedPokemonCell(pokemon: pokemon)
                            .onAppear {
                                viewModel.handleNextPage(pokemon: pokemon.wrappedValue)
                            }
                            .onTapGesture {
                                coordinator.showDetail(pokemon: pokemon.wrappedValue)
                            }
                            .frame(height: height)
                            .shadow(color: .black, radius: 1)
                            .hoverEffect(.automatic)
                    }
                }
                .padding()
            }.onAppear {
                viewModel.loadPokemons()
            }
            PhotosPicker(selection: $whatIsThatPokemon, matching: .images) {
                Image(systemName: "camera")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
            }
            .clipShape(Circle())
            .padding()
        }
        .onChange(of: whatIsThatPokemon, handleOnChangeImageSelect)
        .navigationTitle("Pokédex - Generation 1")
    }
    
    private func handleOnChangeImageSelect() {
        Task {
            do {
                let data = try await whatIsThatPokemon?.loadTransferable(type: Data.self)
                guard let unwrapData = data, let ciImage = CIImage(data: unwrapData) else {
                    return
                }
                
                let model = try VNCoreMLModel(for: Pokedex3(configuration: MLModelConfiguration()).model)
                
                let request = VNCoreMLRequest(model: model)
                request.imageCropAndScaleOption = .centerCrop
                #if targetEnvironment(simulator)
                    request.usesCPUOnly = true
                #endif
                
                let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
                
                try handler.perform([request])
                
                guard let results = request.results as? [VNClassificationObservation],
                      let topClassification = results.first else {
                    return
                }
                
                coordinator.showDetail(pokemon: .init(predictionName: topClassification.identifier))
                
            } catch {
                print(error)
            }
        }
    }
    
}

#Preview(windowStyle: .plain) {
    class PreviewFeedViewModel: FeedViewModelProtocol {
        var list: [FeedModel.Pokemon] = [FeedModel.Pokemon(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")]
        
        func loadPokemons() {}
        
        func handleNextPage(pokemon: FeedModel.Pokemon) {}
    }
    
    return FeedView(viewModel: PreviewFeedViewModel())
}

