//
//  ContentView.swift
//  pokedex
//
//  Created by Ragesh on 1/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter { $0.name.contains(searchText.lowercased()) }) { entry in
                    HStack {
                        
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing,20)
                        NavigationLink("\(entry.name.capitalized)",
                                       destination: {
                            
                            PokemonCardView(imageLink: "\(entry.url)")
//                            VStack {
//                                PokemonImage(imageLink: "\(entry.url)",width: 250,height: 250).padding(.trailing,30)
////                                AsyncImageView(imageUrl: entry.url)
//                                Text(entry.name.capitalized)
//                            }
                        })
                    }
                }
                
                
                
            }
            .onAppear{
                PokeApi().getData { pokemon in
                    self.pokemon = pokemon
                    
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
