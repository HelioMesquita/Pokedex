# Pokédex for VisionPro

[![Swift 5.10](https://img.shields.io/badge/Swift-5.10-blue.svg?style=flat)](https://swift.org)
[![Xcode 15.3.0](https://img.shields.io/badge/Xcode-15.3.0-blue.svg?style=flat)](https://developer.apple.com/xcode/)

A Vision Pro app using SwiftUI with MVVM with NavigationPath to handle the navigation as Coordinator pattern. This app contains all Pokemons from 1st Generation. 

## Feature
- Custom `.mldodel` that identifies the 151 Pokemons (not available in simulator)
- 3D model for some Pokemons that opens in volumetric window
- MVVM for SwiftUI
- NavigationPath to coordinate the navigation flow
- No UIKit 🎉
- Application is testable (On progress)

Note: It's important to note that the ML model may not perform optimally in the simulator due to the unavailability of NeuralProcessing. For more accurate results, it's recommended to test on an iPad.

Images: 

<img src="https://github.com/HelioMesquita/Pokedex/blob/main/.images/Screenshot2.jpg">

<img src="https://github.com/HelioMesquita/Pokedex/blob/main/.images/Screenshot1.jpg">
