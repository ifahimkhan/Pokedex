import SwiftUI

struct PokemonCardView: View {
    @State private var pokemon: PokemonHolder = PokemonHolder()
    var imageLink = ""
    @State private var pokemonSprite = ""

    var body: some View {
        VStack {
            // Image
            PokemonImage(imageLink: imageLink,width: 150,height: 150)
            
            
            // Name
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            // Type, Weight, Power, HP
            HStack {
                Text("Type: \(pokemon.type)")
                Spacer()
                Text("Weight: \(pokemon.weight)")
                Spacer()
                Text("Power HP: \(pokemon.powerHP)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.bottom, 5)
            
            // Stats: Attack and Defence
            HStack {
                Text("Attack: \(pokemon.attack)")
                Spacer()
                Text("Defence: \(pokemon.defence)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            
            Spacer()
        }
        .onAppear{
            getPokemonHolder(url: imageLink)
        }
        .padding()
        .cornerRadius(15)
        .shadow(radius: 5)
        
    }
    
    func getPokemonHolder(url:String){
        var tempHolder:PokemonHolder?
        PokemonDetailsApi().getData(url: url){
            holder in
            switch holder {
            case .success(let pokemonHolder):
                // Handle success
                print("CV Received Pokemon Holder: \(pokemonHolder)")
                tempHolder = pokemonHolder
                self.pokemon = tempHolder ?? PokemonHolder()
                self.pokemonSprite = tempHolder?.imageUrl ?? "placeholder"
            case .failure(let error):
                // Handle error
                print(" CV Error: \(error)")
                
                self.pokemon = PokemonHolder()
                self.pokemonSprite = "placeholder"
            }
            
        }
    }
}

struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

struct PokemonHolder {
    var name: String
    var type: String
    var weight: Double
    var powerHP: Int
    var attack: Int
    var defence: Int
    var imageUrl: String
    
    // Default initializer
    init() {
        self.name = "Charizard"
        self.type = "Fire/Flying"
        self.weight = 30.0
        self.powerHP = 50
        self.attack = 40
        self.defence = 30
        self.imageUrl = ""
    }
}

// Extension providing a custom initializer
extension PokemonHolder {
    init(stats: PokemonDetails) {
        // Extracting information from PokemonStats
        self.name = stats.name // Replace with the actual logic to extract the name
        self.type = stats.types.first?.type.name ?? "Unknown Type"
        self.weight = Double(stats.weight)
        self.powerHP = stats.stats.first { $0.stat.name == "hp" }?.baseStat ?? 0
        self.attack = stats.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
        self.defence = stats.stats.first { $0.stat.name == "defense" }?.baseStat ?? 0
        self.imageUrl = stats.sprites.front_default // Replace with the actual logic to extract the image URL
    }
}


