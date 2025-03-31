import SwiftUI

struct BillyPromotionView: View {
    var onComplete: () -> Void
    @State private var showBilly: Bool = true
    @State private var billyMessage: String = "Let's do some workouts and earn bonuses to get you closer to your goals!"

    var body: some View {
        VStack {
            if showBilly {
                Image("billy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0))
                Text(billyMessage)
                    .font(.title)
                    .padding()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0))
                Button(action: {
                    onComplete()
                }) {
                    Text("Start Now")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .transition(.opacity)
                .animation(.easeInOut(duration: 1.0))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showBilly = false
                onComplete()
            }
        }
    }
}
