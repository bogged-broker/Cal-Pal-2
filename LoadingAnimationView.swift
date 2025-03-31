struct LoadingAnimationView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Image("billy_running")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear {
                    self.isAnimating = true
                }
            Text("Analyzing...")
                .font(.headline)
                .padding()
        }
    }
}

