import SwiftUI

struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    @StateObject var favoritesViewModel = FavoritesViewModel() // Crie uma instância do FavoritesViewModel

    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(searchText == "" ? pokemon : pokemon.filter({ $0.name.contains(searchText.lowercased()) })) { entry in
                        NavigationLink(destination: PokemonDetailView(pokemon: entry, favoritesViewModel: favoritesViewModel)) {
                            HStack {
                                PokemonImage(imageLink: "\(entry.url)")
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .background(Circle().fill(Color.gray.opacity(0.2)))
                                    .padding(.trailing, 20)

                                Text("\(entry.name)".capitalized)
                            }
                        }
                    }
                }
                .onAppear {
                    PokeApi().getData() { pokemon in
                        self.pokemon = pokemon
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("PokedexUI")
            }
            .tabItem {
                Label("Lista", systemImage: "list.dash")
            }

            FavoritesListView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Favoritos", systemImage: "star.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
