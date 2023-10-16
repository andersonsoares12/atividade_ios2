import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    @State private var showingAlert = false
    @State private var selectedItem: PokemonEntry?

    var body: some View {
        List {
            ForEach(favoritesViewModel.favoritePokemons) { favoritePokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: favoritePokemon, favoritesViewModel: favoritesViewModel)) {
                    HStack {
                        PokemonImage(imageLink: "\(favoritePokemon.url)")
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .background(Circle().fill(Color.gray.opacity(0.2)))
                            .padding(.trailing, 20)
                        
                        Text("\(favoritePokemon.name)".capitalized)
                    }
                }
            }
            .onDelete { indexSet in
                if let index = indexSet.first {
                    selectedItem = favoritesViewModel.favoritePokemons[index]
                    showingAlert = true
                }
            }
        }
        .navigationTitle("Pokémon Favoritos")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Atenção"),
                message: Text("Deseja remover este item?"),
                primaryButton: .destructive(Text("Remover")) {
                    if let item = selectedItem {
                        favoritesViewModel.removeFavorite(item)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

