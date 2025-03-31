import SwiftUI

struct BadgeDetailView: View {
    var badge: Badge
    var user: UserModel
    var onClose: () -> Void

    @State private var showBeforeAfter: Bool = false

    var body: some View {
        VStack {
            Text(badge.name)
                .font(.largeTitle)
                .padding()
            Text(badge.description)
                .font(.body)
                .padding()

            // Motivational message
            Text(motivationalMessage(for: badge))
                .font(.headline)
                .padding()
                .transition(.opacity)
                .animation(.easeInOut(duration: 1.0))

            // Badge animation
            badgeAnimation(for: badge)
                .padding()

            if showBeforeAfter {
                VStack {
                    Text("Before")
                    ProgressView(value: user.points - badgePoints(for: badge), total: 2000) // Example previous points
                        .progressViewStyle(LinearProgressViewStyle(tint: progressColor(for: user.points - badgePoints(for: badge))))
                        .padding()

                    Text("After")
                    ProgressView(value: user.points, total: 2000) // Example current points
                        .progressViewStyle(LinearProgressViewStyle(tint: progressColor(for: user.points)))
                        .padding()
                }
                .transition(.slide)
                .animation(.easeInOut(duration: 0.5))
            }

            Button(action: {
                withAnimation {
                    showBeforeAfter.toggle()
                }
            }) {
                Text(showBeforeAfter ? "Hide Details" : "Show Before/After")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: onClose) {
                Text("Close")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    private func progressColor(for points: Double) -> Color {
        switch points {
        case 0..<500:
            return Color.green
        case 500..<1000:
            return Color.yellow
        case 1000..<1500:
            return Color.orange
        case 1500..<2000:
            return Color.red
        default:
            return Color.purple
        }
    }

    private func badgePoints(for badge: Badge) -> Double {
        // Placeholder logic for badge points
        switch badge.difficulty {
        case 1:
            return 50
        case 2:
            return 100
        case 3:
            return 150
        case 4:
            return 200
        case 5:
            return 250
        default:
            return 0
        }
    }

    private func motivationalMessage(for badge: Badge) -> String {
        switch badge.difficulty {
        case 1:
            return "Great start! Keep going!"
        case 2:
            return "You're doing amazing! Keep it up!"
        case 3:
            return "Fantastic work! You're halfway there!"
        case 4:
            return "Incredible effort! Almost at the top!"
        case 5:
            return "You're in the top 1%! Outstanding!"
        default:
            return "Keep pushing forward!"
        }
    }

    private func badgeAnimation(for badge: Badge) -> some View {
        switch badge.difficulty {
        case 1:
            return AnyView(Text("🎉").font(.largeTitle).transition(.scale))
        case 2:
            return AnyView(Text("🔥").font(.largeTitle).transition(.scale))
        case 3:
            return AnyView(Text("💪").font(.largeTitle).transition(.scale))
        case 4:
            return AnyView(Text("🏆").font(.largeTitle).transition(.scale))
        case 5:
            return AnyView(Text("🌟").font(.largeTitle).transition(.scale))
        default:
            return AnyView(Text("🎖️").font(.largeTitle).transition(.scale))
        }
    }
}

struct BadgeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeDetailView(badge: Badge(id: UUID(), name: "Newbie", difficulty: 1, description: "Completed your first workout"), user: UserModel(id: UUID(), name: "Test User", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date(), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], badges: []), onClose: {})
    }
}