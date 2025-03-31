import SwiftUI

struct FallingLeafView: View {
    @State private var animate = false

    var body: some View {
        Image(systemName: "leaf.fill")
            .foregroundColor(.green)
            .offset(y: animate ? UIScreen.main.bounds.height : -50)
            .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
            .onAppear {
                self.animate = true
            }
    }
}

struct FallingLeafView_Previews: PreviewProvider {
    static var previews: some View {
        FallingLeafView()
    }
}