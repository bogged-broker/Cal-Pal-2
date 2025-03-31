import Foundation

struct Achievement: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let difficulty: Difficulty
    let isUnlocked: Bool

    enum Difficulty: String, Codable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        case veryHard = "Very Hard"
        case topOnePercent = "Top 1%"
    }
}