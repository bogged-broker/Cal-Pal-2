import SwiftUI

struct BillyRecommendationView: View {
    var body: some View {
        VStack {
            Image("billy_laptop")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Check out these meal recommendations perfect for you!")
                .font(.title2)
                .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
