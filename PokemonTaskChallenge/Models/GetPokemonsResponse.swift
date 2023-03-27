//
//  PokemonsModel.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 23.03.2023.
//

import Foundation

struct GetPokemonsResponse: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
    
    struct Pokemon: Codable {
        let name: String
        let url: String
    }

    
}

extension GetPokemonsResponse.Pokemon {
    var pokemonID: String {
        URL(string: url)?.lastPathComponent ?? ""
    }
}
