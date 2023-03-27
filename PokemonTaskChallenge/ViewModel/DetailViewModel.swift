//
//  DetailViewModel.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 24.03.2023.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Properties
    
    var abilities: [Ability]?
    var stats: [Stat]?
    var types: [TypeElement]?
    
    var pokemonId: String
    let apiService: PokeAPIService
    var name: String?
    var imageURL: URL?
    
    // MARK: - Initializers
    init(pokemonId: String,name: String?,imageURL: URL?,apiService: PokeAPIService) {
        self.pokemonId = pokemonId
        self.apiService = apiService
        self.imageURL = imageURL
        self.name = name
    }
    
    // MARK: - Public Methods
    
    func fetchPokemonDetails(completion: @escaping () -> Void) {
        apiService.getPokemon(by: pokemonId) { [weak self] response in
            guard let self = self else { return }
            self.name = response.name
            self.abilities = response.abilities
            self.types = response.types
            self.stats = response.stats
            if let urlString = response.sprites?.other?.officialArtwork?.frontDefault {
                self.imageURL = URL(string: urlString)
            }
            completion()
        }
    }
    
}
