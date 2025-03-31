struct UserModel: Identifiable, Codable {
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
    var followedUsers: [UUID] // List of followed users' IDs
    var avatar: String // Add this property
    var theme: String // Add this property
}

enum WorkoutType {
    case weights
    case running
    case treadmill
    // Add other workout types as needed
}