import SwiftUI

struct GoldenLogoView: View {
    var workoutType: BonusWorkoutType

    var body: some View {
        let imageName: String
        switch workoutType {
        case .weights:
            imageName = "dumbbell.fill"
        case .running:
            imageName = "figure.walk"
        case .treadmill:
            imageName = "treadmill.fill"
        // Add other cases as needed
        }

        return Image(systemName: imageName)
            .foregroundColor(.yellow)
            .scaleEffect(1.5)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
    }
}

struct GoldenLogoView_Previews: PreviewProvider {
    static var previews: some View {
        GoldenLogoView(workoutType: .weights)
    }
}