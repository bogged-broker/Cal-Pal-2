import SwiftUI

struct GoldenBillyView: View {
    var body: some View {
        VStack {
            Image("golden_billy")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            Text("You made it to the bonus section!")
                .font(.largeTitle)
                .padding()
            Text("Keep pushing, soldier!")
                .font(.title)
                .padding()
        }
    }
}

struct GoldenBillyView_Previews: PreviewProvider {
    static var previews: some View {
        GoldenBillyView()
    }
}