//
//  Pokemon.swift
//  pokedex
//
//  Created by Ragesh on 1/14/24.
//
//https://pokeapi.co/api/v2/pokemon?offset=0&limit=151

import Foundation

struct Pokemon:Codable{
    
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable,Identifiable{
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi{
    func getData(completion:@escaping([PokemonEntry]) -> ()){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151") else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }
                let pokemonList = try JSONDecoder().decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(pokemonList.results)
                }
            } catch let decodingError as DecodingError {
                print("Decoding error: \(decodingError)")
                // Handle the decoding error appropriately (e.g., show an error message to the user)
            } catch {
                print("Error: \(error)")
                // Handle other errors
            }
        }.resume()

        
    }
}
