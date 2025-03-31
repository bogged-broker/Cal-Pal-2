import SwiftUI

struct AchievementsView: View {
    @Binding var user: UserModel
    @State private var showMotivation: Bool = false

    var body: some View {
        VStack {
            if user.isNew {
                AchievementsAnimationView()
            } else if showMotivation {
                BillyMotivationView(onComplete: {
                    showMotivation = false
                    // Call the method to transition to the graph progress view
                    NotificationCenter.default.post(name: .showGoalTrackingGraph, object: nil)
                })
            } else {
                Text("Achievements")
                    .font(.largeTitle)
                    .padding()

                ScrollView {
                    ForEach(user.achievements) { achievement in
                        AchievementView(achievement: achievement)
                            .padding()
                            .onTapGesture {
                                // Handle achievement completion
                                completeAchievement(achievement)
                            }
                    }
                }
            }
        }
        .padding()
    }

    private func completeAchievement(_ achievement: Achievement) {
        // Update the user's achievements
        if let index = user.achievements.firstIndex(where: { $0.id == achievement.id }) {
            user.achievements[index].isCompleted = true
        }
        // Show Billy's motivational message
        showMotivation = true
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(user: .constant(UserModel(id: UUID(), name: "Test User", points: 1000, workouts: 400, bonuses: 200, meals: 150, recommended: 100, isNew: true, isOnStreak: true, streakLost: false, bonusWorkoutType: nil, bonusWorkoutTimestamp: nil, joinTimestamp: Date(), workoutType: nil, mealPlanCompleted: true, followedUsers: [], avatar: "avatar1", theme: "Light")))
    }
}