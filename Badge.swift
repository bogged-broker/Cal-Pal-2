import Foundation

struct Badge: Identifiable {
    let id: UUID
    let name: String
    let difficulty: Int // 1 to 5, 5 being the hardest
    let description: String
}

let badges: [Badge] = [
    Badge(id: UUID(), name: "Newbie", difficulty: 1, description: "Completed your first workout"),
    Badge(id: UUID(), name: "Rookie", difficulty: 1, description: "Completed 10 workouts"),
    Badge(id: UUID(), name: "Intermediate", difficulty: 2, description: "Completed 50 workouts"),
    Badge(id: UUID(), name: "Advanced", difficulty: 3, description: "Completed 100 workouts"),
    Badge(id: UUID(), name: "Pro", difficulty: 4, description: "Completed 200 workouts"),
    Badge(id: UUID(), name: "Elite", difficulty: 5, description: "Completed 500 workouts"),
    Badge(id: UUID(), name: "Top 1%", difficulty: 5, description: "Ranked in the top 1% of users"),
    // Add more badges as needed
]