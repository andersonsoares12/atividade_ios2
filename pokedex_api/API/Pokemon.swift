import Foundation
import SwiftUI

struct Pokemon: Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    var id: UUID? = UUID()
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name, url
    }
}

struct PokemonAbility: Codable {
    var ability: Ability
}

struct Ability: Codable {
    var name: String
}

struct PokemonStat: Codable {
    var baseStat: Int
    var stat: Stat
}

struct Stat: Codable {
    var name: String
}

struct PokemonType: Codable {
    var type: Type
}

struct Type: Codable {
    var name: String
}

class PokeApi {
    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let pokemonList = try decoder.decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(pokemonList.results)
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
            }
        }.resume()
    }

    // Restante do seu código não precisa de alterações.
    // ...
}
