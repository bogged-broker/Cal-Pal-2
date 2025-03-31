import SwiftUI

struct UserDetailView: View {
    var user: UserModel
    @State private var message: String = ""
    @State private var messages: [String] = []
    @State private var reactions: [String: String] = [:] // Message to reaction mapping

    var body: some View {
        VStack {
            Text("\(user.name)'s Goal Tracking")
                .font(.largeTitle)
                .padding()

            // Goal tracking graph
            ProgressView(value: user.points, total: 2000) // Example goal
                .progressViewStyle(LinearProgressViewStyle(tint: progressColor(for: user.points)))
                .padding()
                .animation(.easeInOut(duration: 0.5), value: user.points)

            // Display all badges
            Text("Badges Earned")
                .font(.title2)
                .padding()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(user.badges) { badge in
                        BadgeView(badge: badge, user: user)
                    }
                }
            }
            .padding()

            // Progress towards next badge
            Text("Progress Towards Next Badge")
                .font(.title2)
                .padding()
            ProgressView(value: progressTowardsNextBadge(), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                .padding()

            // Props button
            Button(action: {
                // Logic to give props to the user
            }) {
                Text("Give Props")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Messaging bar
            VStack {
                ScrollView {
                    ForEach(messages, id: \.self) { msg in
                        HStack {
                            Text(msg)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            Spacer()
                            if let reaction = reactions[msg] {
                                Text(reaction)
                                    .padding()
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                reactions[msg] = "😊"
                            }) {
                                Text("😊")
                            }
                            Button(action: {
                                reactions[msg] = "👍"
                            }) {
                                Text("👍")
                            }
                            Button(action: {
                                reactions[msg] = "🎉"
                            }) {
                                Text("🎉")
                            }
                            Button(action: {
                                reactions[msg] = "💪"
                            }) {
                                Text("💪")
                            }
                        }
                    }
                }
                .frame(height: 200)

                HStack {
                    TextField("Enter your message", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if (!message.isEmpty) {
                            messages.append(message)
                            message = ""
                        }
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()

                // Animated emojis
                HStack {
                    AnimatedEmojiView(emoji: "😊")
                    AnimatedEmojiView(emoji: "👍")
                    AnimatedEmojiView(emoji: "🎉")
                    AnimatedEmojiView(emoji: "💪")
                }
                .padding()
            }
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

    private func progressTowardsNextBadge() -> Double {
        // Placeholder logic for progress towards next badge
        return Double.random(in: 0...100)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: UserModel(id: UUID(), name: "Alice", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date(), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], badges: [Badge(id: UUID(), name: "Marathon Runner", difficulty: 5), Badge(id: UUID(), name: "Ironman", difficulty: 4)]))
    }
}