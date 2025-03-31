import SwiftUI

struct BillyCongratsView: View {
    var userRank: Int
    var onComplete: () -> Void

    var body: some View {
        VStack {
            Image("billy_cool")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            Text("Nice work!")
                .font(.title)
                .padding()
            Text("You're now ranked \(userRank) on the leaderboard!")
                .font(.subheadline)
                .padding()
            Text("Don't stop!")
                .font(.subheadline)
                .padding()
            Button(action: onComplete) {
                Text("Continue")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct BillyCongratsView_Previews: PreviewProvider {
    static var previews: some View {
        BillyCongratsView(userRank: 1, onComplete: {})
    }
}