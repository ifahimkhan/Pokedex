//
//  PokemonImage.swift
//  pokedex
//
//  Created by Ragesh on 1/14/24.
//

import SwiftUI

struct PokemonImage: View {
    var imageLink = ""
    var width:CGFloat=95
    var height:CGFloat=95
    @State private var pokemonSprite = ""
    var body: some View {
        
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: width,height: height)
            .onAppear{
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                if loadedData == nil{
                    getSprite(url: imageLink)
                    print("New URL caching")
                }else{
//                    getSprite(url: loadedData!)
                    self.pokemonSprite = loadedData!
                    print("Using cached url...")
                }
//                getSprite(url: imageLink)

            }
    }
    func getSprite(url:String){
        print("\(url)")
        var tempSprite:String?
        PokemonDetailsApi().getData(url: url){
            sprite in
            switch sprite {
            case .success(let pokemonHolder):
                // Handle success
                print("Received Pokemon Holder: \(pokemonHolder)")
                
                
                tempSprite = pokemonHolder.imageUrl
                self.pokemonSprite = tempSprite ?? "placeholder"
                UserDefaults.standard.set(self.pokemonSprite,forKey: imageLink)

            case .failure(let error):
                // Handle error
                print("Error: pokemon image \(error)")
                
                self.pokemonSprite = "placeholder"
                
            }
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
