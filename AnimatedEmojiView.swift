import SwiftUI

struct AnimatedEmojiView: View {
    var emoji: String
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0

    var body: some View {
        Text(emoji)
            .font(.largeTitle)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            .onAppear {
                self.scale = 1.5
                self.rotation = 360
            }
    }
}

struct AnimatedEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedEmojiView(emoji: "😊")
    }
}