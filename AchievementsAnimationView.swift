import SwiftUI

struct AchievementsAnimationView: View {
    @State private var showAnimation: Bool = true
    @State private var showBilly: Bool = false

    var body: some View {
        VStack {
            if showAnimation {
                // Add your animation code here
                Text("Exploding Animation")
                    .font(.largeTitle)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 1.0))
            } else if showBilly {
                VStack {
                    Image("billy_cool")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Welcome to the badges and achievements.")
                        .font(.title)
                        .padding()
                    Text("Unlock more badges and climb up to the leaderboard and reach your goal even faster.")
                        .font(.subheadline)
                        .padding()
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 1.0))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showAnimation = false
                    showBilly = true
                }
            }
        }
    }
}

struct AchievementsAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsAnimationView()
    }
}