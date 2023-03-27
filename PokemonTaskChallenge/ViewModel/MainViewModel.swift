//
//  MainViewModel.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 24.03.2023.
//

import Foundation


class MainViewModel {

    weak var delegate: MainViewModelDelegate?
    var pokemons: [GetPokemonsResponse.Pokemon] = []

    func fetchPokemons() {
        PokeAPIService.shared.getPokemons { response in
            self.pokemons = response.results
            self.delegate?.didFetchPokemons()
        }
    }

   func getPokemonSpritesURL(for index: Int) -> URL {
       let pokemon = pokemons[index]
       return PokeAPIService.shared.getPokemonSprites(id: pokemon.pokemonID)!
   }
   func getPokemonDetailURL(for index: Int) -> URL {
       let pokemon = pokemons[index]
       return PokeAPIService.shared.getPokemonOfficialArtwork(id: pokemon.pokemonID)!
   }

}

protocol MainViewModelDelegate: AnyObject {
    func didFetchPokemons()
}
