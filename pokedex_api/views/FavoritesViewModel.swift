//
//  FavoritesViewModel.swift
//  pokedex_api
//
//  Created by Anderson dos Santos Soares on 16/10/23.
//

import Foundation
class FavoritesViewModel: ObservableObject {
    @Published var favoritePokemons: [PokemonEntry] = []
    
    func toggleFavorite(_ pokemon: PokemonEntry) {
        if let index = favoritePokemons.firstIndex(where: { $0.id == pokemon.id }) {
            favoritePokemons.remove(at: index)
        } else {
            favoritePokemons.append(pokemon)
        }
    }
    
    func removeFavorite(_ pokemon: PokemonEntry) {
        if let index = favoritePokemons.firstIndex(where: { $0.id == pokemon.id }) {
            favoritePokemons.remove(at: index)
        }}
}
