//
//  PokeAPIService.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 22.03.2023.
//

import Foundation

class PokeAPIService {
    
    static let shared = PokeAPIService()
    let pokemonNumber = 30
    
    func getPokemons(completion: @escaping (GetPokemonsResponse) -> Void) {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=\(pokemonNumber)") else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(GetPokemonsResponse.self, from: data)
                    completion(response)
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    
    
    
    func getPokemon(by id: String, completion: @escaping (GetPokemonDetailResponse) -> Void) {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(GetPokemonDetailResponse.self, from: data)
                    completion(response)
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    
    func getPokemonSprites(id: String) -> URL? {
           URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
       
    func getPokemonOfficialArtwork(id: String) -> URL?{
           URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
}
