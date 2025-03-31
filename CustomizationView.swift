import SwiftUI

struct CustomizationView: View {
    @State private var selectedAvatar: String = "avatar1"
    @State private var selectedTheme: String = "Light"
    @Binding var user: UserModel

    var body: some View {
        VStack {
            AvatarSelectionView(selectedAvatar: $selectedAvatar)
            ThemeSelectionView(selectedTheme: $selectedTheme)

            Button(action: {
                user.avatar = selectedAvatar
                user.theme = selectedTheme
                saveUserPreferences(user)
            }) {
                Text("Save")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    private func saveUserPreferences(_ user: UserModel) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "userPreferences")
        }
    }
}

struct CustomizationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizationView(user: .constant(UserModel(id: UUID(), name: "Alice", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date(), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], avatar: "avatar1", theme: "Light")))
    }
}