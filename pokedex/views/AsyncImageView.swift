import SwiftUI

struct AsyncImageView: View {
    
    var imageLink = ""
    var name = ""

    var body: some View {
        VStack{
            PokemonImage(imageLink: imageLink,width: 150,height: 150)
            Text(name.capitalized)
            
        }
       
    }
}
struct AsyncImageView_Preview: PreviewProvider {
    static var previews: some View {
        AsyncImage()
    }
}


