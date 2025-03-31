import SwiftUI

struct LeaderboardView: View {
    @State private var users: [UserModel] = [
        UserModel(id: UUID(), name: "Alice", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date().addingTimeInterval(-3600), joinTimestamp: Date().addingTimeInterval(-604800), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], badges: [Badge(id: UUID(), name: "Marathon Runner", difficulty: 5), Badge(id: UUID(), name: "Ironman", difficulty: 4)]), // 1 week ago
        UserModel(id: UUID(), name: "Bob", points: 1100, workouts: 400, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: false, streakLost: true, bonusWorkoutType: .running, bonusWorkoutTimestamp: Date().addingTimeInterval(-90000), joinTimestamp: Date().addingTimeInterval(-604800), workoutType: .running, mealPlanCompleted: false, followedUsers: [], badges: [Badge(id: UUID(), name: "Half Marathon", difficulty: 3)]), // 1 week ago
        UserModel(id: UUID(), name: "Charlie", points: 900, workouts: 300, bonuses: 200, meals: 200, recommended: 200, isNew: true, isOnStreak: false, streakLost: false, bonusWorkoutType: .treadmill, bonusWorkoutTimestamp: Date().addingTimeInterval(-3600), joinTimestamp: Date().addingTimeInterval(-3600), workoutType: .treadmill, mealPlanCompleted: true, followedUsers: [], badges: [Badge(id: UUID(), name: "Newbie", difficulty: 1)]), // 1 hour ago
        UserModel(id: UUID(), name: "David", points: 800, workouts: 300, bonuses: 200, meals: 100, recommended: 200, isNew: false, isOnStreak: false, streakLost: false, bonusWorkoutType: nil, bonusWorkoutTimestamp: nil, joinTimestamp: Date().addingTimeInterval(-604800), workoutType: nil, mealPlanCompleted: true, followedUsers: [], badges: []), // 1 week ago
        UserModel(id: UUID(), name: "Eve", points: 700, workouts: 200, bonuses: 200, meals: 100, recommended: 200, isNew: false, isOnStreak: false, streakLost: false, bonusWorkoutType: nil, bonusWorkoutTimestamp: nil, joinTimestamp: Date().addingTimeInterval(-604800), workoutType: nil, mealPlanCompleted: true, followedUsers: [], badges: []) // 1 week ago
    ]
    @State private var selectedUser: UserModel? = nil
    @State private var currentUser: UserModel = UserModel(id: UUID(), name: "Current User", points: 1000, workouts: 400, bonuses: 200, meals: 150, recommended: 100, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: nil, bonusWorkoutTimestamp: nil, joinTimestamp: Date(), workoutType: nil, mealPlanCompleted: true, followedUsers: [], badges: [])
    var onFollowUser: ((UserModel) -> Void)?

    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()

            List(users.sorted(by: { $0.points > $1.points })) { user in
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Workouts: \(user.workouts)")
                            Text("Bonuses: \(user.bonuses)")
                            Text("Meals: \(user.meals)")
                            Text("Recommended: \(user.recommended)")
                        }
                        .font(.subheadline)
                    }
                    Spacer()
                    Text("\(user.points, specifier: "%.0f") points")
                        .font(.subheadline)
                    
                    HStack(spacing: 10) {
                        if let joinTimestamp = user.joinTimestamp, Date().timeIntervalSince(joinTimestamp) <= 604800 {
                            FallingLeafView()
                        }
                        
                        if user.isOnStreak {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.red)
                                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                        }
                        
                        if user.streakLost {
                            Text("STREAK LOST")
                                .font(.caption)
                                .foregroundColor(.red)
                                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                        }
                        
                        if let workoutType = user.bonusWorkoutType, let timestamp = user.bonusWorkoutTimestamp, Date().timeIntervalSince(timestamp) <= 86400 {
                            GoldenLogoView(workoutType: workoutType)
                        }
                        
                        if let workoutType = user.workoutType {
                            WorkoutLogoView(workoutType: workoutType)
                        }
                    }
                    
                    // Display the hardest badges
                    ForEach(user.badges.sorted(by: { $0.difficulty > $1.difficulty }).prefix(3)) { badge in
                        Text(badge.name)
                            .font(.caption)
                            .padding(4)
                            .background(Color.yellow)
                            .cornerRadius(4)
                    }
                    
                    Button(action: {
                        followUser(user)
                    }) {
                        Text(currentUser.followedUsers.contains(user.id) ? "Following" : "Follow")
                            .padding()
                            .background(currentUser.followedUsers.contains(user.id) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .onTapGesture {
                    selectedUser = user
                }
            }
        }
        .padding()
        .sheet(item: $selectedUser) { user in
            UserDetailView(user: user)
        }
    }

    private func followUser(_ user: UserModel) {
        if currentUser.followedUsers.contains(user.id) {
            currentUser.followedUsers.removeAll { $0 == user.id }
        } else {
            currentUser.followedUsers.append(user.id)
        }
        saveCurrentUser()
        onFollowUser?(user)
    }

    private func saveCurrentUser() {
        if let encoded = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
    }
}

struct UserModel: Identifiable {
    let id: UUID
    let name: String
    let points: Double
    let workouts: Double
    let bonuses: Double
    let meals: Double
    let recommended: Double
    let isNew: Bool
    let isOnStreak: Bool
    let streakLost: Bool
    let bonusWorkoutType: WorkoutType?
    let bonusWorkoutTimestamp: Date?
    let joinTimestamp: Date?
    let workoutType: WorkoutType?
    let mealPlanCompleted: Bool
    var followedUsers: [UUID]
    var badges: [Badge] // New property for badges
}

struct Badge: Identifiable {
    let id: UUID
    let name: String
    let difficulty: Int // 1 to 5, 5 being the hardest
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

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
                .progressViewStyle(LinearProgressViewStyle())
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
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: UserModel(id: UUID(), name: "Alice", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date(), workoutType: .weights, mealPlanCompleted: true, followedUsers: [], badges: []))
    }
}