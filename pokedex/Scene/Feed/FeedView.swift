//
//  FeedView.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedView: View {
    
    @State var viewModel = ViewModel()
    let height: CGFloat = 200
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($viewModel.list) { pokemon in
                        PokeView(pokemon: pokemon.wrappedValue)
                            .onAppear {
                                viewModel.handleNextPage(pokemon: pokemon.wrappedValue)
                            }
                            .frame(height: height)
                    }
                }
                .padding()
            }.onAppear {
                viewModel.loadPokemon()
            }
        }
        
    }
}

struct PokeView: View {
    let pokemon: PokemonFeed.Pokemon
    
    @State var backgroundColor = Color.clear
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                Spacer()
                WebImage(url: URL(string: pokemon.imageURL))
                    .onSuccess { image, _, _ in
                            if let averageColor = AverageColorUtility.getAverageColor(for: image, side: .bottom) {
                                backgroundColor = Color(averageColor)
                            }
                        }
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipped()
                    .padding(20)
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
            }.clipShape(RoundedRectangle(cornerRadius: 12))
            Text(pokemon.name.capitalized)
                .font(.title2)
        }.clipped()
    }
}

//#Preview(windowStyle: .automatic) {
//    FeedView()
//}

extension FeedView {
    
    @Observable
    class ViewModel {
        
        var currentPage = 0
        var hasNextPage = false
        var list: [PokemonFeed.Pokemon] = []
        
        let service: ServiceProtocol
        
        init(service: ServiceProtocol = Service()) {
            self.service = service
        }
        
        func loadPokemon() {
            guard list.isEmpty else { return }
            fetchPokemonList()
        }
        
        func fetchPokemonList() {
            Task { @MainActor in
                do {
                    let pokemonFeed = try await service.execute(PokemonFeedRequest(page: currentPage), builder: PokemonFeedBuilder())
                    hasNextPage = pokemonFeed.next != nil
                    list.append(contentsOf: pokemonFeed.results)
                } catch {
                    
                }
            }
        }
        
        func handleNextPage(pokemon: PokemonFeed.Pokemon) {
            if pokemon == list.last && hasNextPage {
                currentPage += 1
                fetchPokemonList()
            }
        }
    }
    
}

class PokemonFeedResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonFeedNameResponse]
    
    class PokemonFeedNameResponse: Decodable {
        let name: String
        let url: String
    }
}

class PokemonFeed {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    init(count: Int, next: String?, previous: String?, results: [Pokemon]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    class Pokemon: Identifiable, Equatable {
        
        let id = UUID()
        var name: String
        let url: String
        
        var imageURL: String {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(String(describing: getId)).png"
        }
        
        var getId: Int {
            var id = url.components(separatedBy: "https://pokeapi.co/api/v2/pokemon/").last ?? ""
            id = String(id.dropLast())
            return Int(id) ?? 0
        }
        
        init(name: String, url: String) {
            self.name = name
            self.url = url
        }
        
        static func == (lhs: PokemonFeed.Pokemon, rhs: PokemonFeed.Pokemon) -> Bool {
            return lhs.id == rhs.id
        }
    }
}


class PokemonFeedRequest: RequestProtocol {
    
    var httpVerb: HttpVerbs = .GET
    var path: String = "/api/v2/pokemon"
    var page: Int
    private let numberOfElements = 40
    
    var queryParameters: [URLQueryItem]? {
        return [
            URLQueryItem(name: "offset", value: "\(numberOfElements * page)"),
            URLQueryItem(name: "limit", value: "\(numberOfElements)")
        ]
    }
    
    init(page: Int = 0) {
        self.page = page
    }
    
}

class PokemonFeedBuilder: BuilderProtocol {
    
    func build(response: PokemonFeedResponse) throws -> PokemonFeed {
        return PokemonFeed(count: response.count,
                           next: response.next,
                           previous: response.previous,
                           results: response.results.compactMap({ PokemonFeed.Pokemon(name: $0.name, url: $0.url) }))
    }
    
}

struct AverageColorUtility {
    /// Enum defining the part of a view used for calculating the average color of an image.
    enum Side {
        case bottom
        case left
        case right
        case top
        
        func frame(from size: CGSize) -> CGRect {
            switch self {
            case .bottom:
                CGRect(x: 0,
                       y: size.height * 0.75,
                       width: size.width,
                       height: size.height)
            case .left:
                CGRect(x: 0,
                       y: 0,
                       width: size.width * 0.25,
                       height: size.height)
            case .right:
                CGRect(x: size.width * 0.75,
                       y: 0,
                       width: size.width,
                       height: size.height)
            case .top:
                CGRect(x: 0,
                       y: 0,
                       width: size.width,
                       height: size.height * 0.25)
            }
        }
    }
    
    /// There are two main ways to get the color from an image, just a simple "sum up an average" or by squaring their sums. Each has their advantages, but the 'simple' option *seems* better for average color of entire image and closely mirrors CoreImage. Details: https://sighack.com/post/averaging-rgb-colors-the-right-way
    
    /// Average color of the image. Returns `nil` if the color cannot be found
    static func getAverageColor(for image: UIImage, side: Side) -> UIColor? {
        guard let cgImage = crop(image: image, side: side) else { return nil }
        
        // First, resize the image. We do this for two reasons, 1) less pixels to deal with means faster calculation and a resized image still has the "gist" of the colors, and 2) the image we're dealing with may come in any of a variety of color formats (CMYK, ARGB, RGBA, etc.) which complicates things, and redrawing it normalizes that into a base color format we can deal with.
        // 40x40 is a good size to resize to still preserve quite a bit of detail but not have too many pixels to deal with. Aspect ratio is irrelevant for just finding average color.
        let size = CGSize(width: 40, height: 40)
        
        let width = Int(size.width)
        let height = Int(size.height)
        let totalPixels = width * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // ARGB format
        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        
        // 8 bits for each color channel, we're doing ARGB so 32 bits (4 bytes) total, and thus if the image is n pixels wide, and has 4 bytes per pixel, the total bytes per row is 4n. That gives us 2^8 = 256 color variations for each RGB channel or 256 * 256 * 256 = ~16.7M color options in total. That seems like a lot, but lots of HDR movies are in 10 bit, which is (2^10)^3 = 1 billion color options!
        guard let context = CGContext(data: nil,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: width * 4,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo) else { return nil }
        
        // Draw our resized image
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))
        
        guard let pixelBuffer = context.data else { return nil }
        
        // Bind the pixel buffer's memory location to a pointer we can use/access
        let pointer = pixelBuffer.bindMemory(to: UInt32.self, capacity: width * height)
        
        // Keep track of total colors (note: we don't care about alpha and will always assume alpha of 1, AKA opaque)
        var totalRed = 0
        var totalBlue = 0
        var totalGreen = 0
        
        // Column of pixels in image
        for xPoint in 0 ..< width {
            // Row of pixels in image
            for yPoint in 0 ..< height {
                // To get the pixel location just think of the image as a grid of pixels, but stored as one long row rather than columns and rows, so for instance to map the pixel from the grid in the 15th row and 3 columns in to our "long row", we'd offset ourselves 15 times the width in pixels of the image, and then offset by the amount of columns
                let pixel = pointer[(yPoint * width) + xPoint]
                
                let rPixel = red(for: pixel)
                let gPixel = green(for: pixel)
                let bPixel = blue(for: pixel)
                
                totalRed += Int(rPixel)
                totalBlue += Int(bPixel)
                totalGreen += Int(gPixel)
            }
        }
        
        let averageRed = CGFloat(totalRed) / CGFloat(totalPixels)
        let averageGreen = CGFloat(totalGreen) / CGFloat(totalPixels)
        let averageBlue = CGFloat(totalBlue) / CGFloat(totalPixels)
        
        // Convert from [0 ... 255] format to the [0 ... 1.0] format UIColor wants
        let color = UIColor(red: averageRed / 255.0, green: averageGreen / 255.0, blue: averageBlue / 255.0, alpha: 1.0)
        
        return color
    }
    
    private static func red(for pixelData: UInt32) -> UInt8 {
        return UInt8((pixelData >> 16) & 255)
    }
    
    private static func green(for pixelData: UInt32) -> UInt8 {
        return UInt8((pixelData >> 8) & 255)
    }
    
    private static func blue(for pixelData: UInt32) -> UInt8 {
        return UInt8((pixelData >> 0) & 255)
    }
    
    private static func crop(image: UIImage, side: Side) -> CGImage? {
        let croppedFrame = side.frame(from: image.size)
        return image.cgImage?.cropping(to: croppedFrame)
    }
}
