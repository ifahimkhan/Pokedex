//
//  PokemonDetatils.swift
//  pokedex
//
//  Created by Ragesh on 1/14/24.
//

import Foundation

struct PokemonDetails: Codable{
    var sprites: PokemonSprites
    var weight: Int
    let stats: [Stat]
    let types: [Types]
    let height: Int
    let name: String
}
struct PokemonSprites: Codable{
    var front_default: String
}

//second api call details


struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatDetails

    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct StatDetails: Codable {
    let name: String
    let url: String
}

struct Types: Codable {
    let slot: Int
    let type: TypeDetails
}

struct TypeDetails: Codable {
    let name: String
    let url: String
}


class PokemonDetailsApi{
//    func getData(url: String,completion: @escaping(PokemonSprites) -> ()){
//        guard let url = URL(string: url) else{return}
//        URLSession.shared.dataTask(with: url){(Data,response,error) in
//            guard let Data = Data else{return}
//            let pokemonDetails = try! JSONDecoder().decode(PokemonDetails.self,from: Data)
//            DispatchQueue.main.async {
//                completion(pokemonDetails.sprites)
//            }
//        }.resume()
//
//    }
    func getData(url: String, completion: @escaping (Result<PokemonHolder, Error>) -> ()) {
        guard let url = URL(string: url) else {
            // Handle the invalid URL case
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    // Handle the case where data is nil
                    throw NSError(domain: "No data received", code: 1, userInfo: nil)
                }

                let pokemonStats = try JSONDecoder().decode(PokemonDetails.self, from: data)
                let pokemonHolder = PokemonHolder(stats: pokemonStats)
                DispatchQueue.main.async {
                    completion(.success(pokemonHolder))
                }
            } catch {
                // Handle decoding errors
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
