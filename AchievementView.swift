import SwiftUI

struct AchievementsView: View {
    @State private var achievements: [Achievement] = loadAchievements()
    @State private var selectedAchievement: Achievement?

    var body: some View {
        VStack {
            Text("Achievements")
                .font(.largeTitle)
                .padding()

            ScrollView {
                ForEach(achievements) { achievement in
                    HStack {
                        Image(systemName: achievement.isUnlocked ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(achievement.isUnlocked ? .yellow : .gray)
                            .onTapGesture {
                                selectedAchievement = achievement
                            }
                        Text(achievement.name)
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    .padding()
                    .background(achievement.isUnlocked ? Color.white : Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
        .sheet(item: $selectedAchievement) { achievement in
            AchievementDetailView(achievement: achievement)
        }
    }

    private static func loadAchievements() -> [Achievement] {
        // Load achievements from a local JSON file or create default achievements
        return [
            Achievement(id: UUID(), name: "Run 10 Miles", description: "Run a total of 10 miles.", difficulty: .easy, isUnlocked: false, animationName: "run10miles"),
            Achievement(id: UUID(), name: "Complete 50 Workouts", description: "Complete a total of 50 workouts.", difficulty: .medium, isUnlocked: false, animationName: "complete50workouts"),
            Achievement(id: UUID(), name: "Lose 10 Pounds", description: "Lose a total of 10 pounds.", difficulty: .hard, isUnlocked: false, animationName: "lose10pounds"),
            Achievement(id: UUID(), name: "Top 1% Performer", description: "Be in the top 1% of performers.", difficulty: .topOnePercent, isUnlocked: false, animationName: "top1percent")
        ]
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}

struct AchievementView: View {
    var achievement: Achievement
    @State private var isHovered: Bool = false

    var body: some View {
        VStack {
            Image(achievement.isUnlocked ? achievement.name : "locked")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
                .background(achievement.isUnlocked ? Color.clear : Color.gray)
                .cornerRadius(10)
                .overlay(
                    Text(achievement.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(5)
                        .padding(5),
                    alignment: .bottom
                )
                .onHover { hovering in
                    withAnimation {
                        isHovered = hovering
                    }
                }
                .overlay(
                    isHovered ? AnyView(
                        VStack {
                            Text(achievement.description)
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            DifficultyView(difficulty: achievement.difficulty)
                                .transition(.move(edge: .bottom))
                        }
                        .padding()
                    ) : AnyView(EmptyView())
                )
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView(achievement: Achievement(id: UUID(), name: "Run 10 Miles", description: "Run a total of 10 miles.", difficulty: .medium, isUnlocked: false))
    }
}