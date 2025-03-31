import SwiftUI

struct AchievementDetailView: View {
    var achievement: Achievement

    var body: some View {
        VStack {
            Text(achievement.name)
                .font(.largeTitle)
                .padding()

            Image(systemName: achievement.isUnlocked ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(achievement.isUnlocked ? .yellow : .gray)
                .padding()

            Text(achievement.description)
                .font(.headline)
                .padding()

            DifficultyView(difficulty: achievement.difficulty)
                .padding()

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct AchievementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementDetailView(achievement: Achievement(id: UUID(), name: "Run 10 Miles", description: "Run a total of 10 miles.", difficulty: .easy, isUnlocked: false, animationName: "run10miles"))
    }
}