import SwiftUI

struct BadgeView: View {
    var badge: Badge
    var user: UserModel
    @State private var isHovered: Bool = false
    @State private var showDetail: Bool = false

    var body: some View {
        VStack {
            Text(badge.name)
                .font(.caption)
                .padding(4)
                .background(badgeColor(for: badge.difficulty))
                .cornerRadius(4)
                .scaleEffect(isHovered ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: isHovered)
                .onHover { hovering in
                    isHovered = hovering
                }
                .onTapGesture {
                    withAnimation {
                        showDetail.toggle()
                    }
                }
            Text("Difficulty: \(badge.difficulty)")
                .font(.caption2)
            ProgressView(value: badgeProgress(for: badge), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: badgeColor(for: badge.difficulty)))
                .padding(.top, 4)
        }
        .padding(4)
        .sheet(isPresented: $showDetail) {
            BadgeDetailView(badge: badge, user: user, onClose: {
                showDetail = false
            })
        }
    }

    private func badgeColor(for difficulty: Int) -> Color {
        switch difficulty {
        case 1:
            return Color.green
        case 2:
            return Color.yellow
        case 3:
            return Color.orange
        case 4:
            return Color.red
        case 5:
            return Color.purple
        default:
            return Color.gray
        }
    }

    private func badgeProgress(for badge: Badge) -> Double {
        // Placeholder logic for badge progress
        return Double.random(in: 0...100)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(badge: Badge(id: UUID(), name: "Newbie", difficulty: 1, description: "Completed your first workout"), user: UserModel(id: UUID(), name: "Test User", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date(), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], badges: []))
    }
}