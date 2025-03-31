import SwiftUI

struct DifficultyView: View {
    var difficulty: Achievement.Difficulty

    var body: some View {
        HStack {
            Text("Difficulty:")
                .font(.headline)
            Text(difficulty.rawValue)
                .font(.headline)
                .foregroundColor(color(for: difficulty))
        }
        .padding()
        .background(color(for: difficulty).opacity(0.2))
        .cornerRadius(10)
    }

    private func color(for difficulty: Achievement.Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .yellow
        case .hard:
            return .red
        case .veryHard:
            return .purple
        case .topOnePercent:
            return .black
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView(difficulty: .medium)
    }
}