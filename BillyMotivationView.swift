import SwiftUI

struct BillyMotivationView: View {
    var onComplete: () -> Void

    var body: some View {
        VStack {
            Image("billy_cool")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Great job!")
                .font(.title)
                .padding()
            Text("Keep unlocking more badges and climb up the leaderboard!")
                .font(.subheadline)
                .padding()
            Button(action: onComplete) {
                Text("View Progress")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct BillyMotivationView_Previews: PreviewProvider {
    static var previews: some View {
        BillyMotivationView(onComplete: {})
    }
}