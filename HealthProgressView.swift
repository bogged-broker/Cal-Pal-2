import SwiftUI

struct HealthProgressView: View {
    @State private var progress: CGFloat = 0.0
    @State private var points: CGFloat = 0.0
    @State private var calories: CGFloat = 0.0
    @State private var goal: String = "maintain" // Possible values: "lose", "gain", "maintain"
    @State private var weightLossGoal: CGFloat = 10.0 // New state variable for weight loss goal

    var body: some View {
        VStack {
            Text("Health Progress")
                .font(.largeTitle)
                .padding()

            ProgressView(value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            Image("billy_working_out")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            

            

            Button(action: {
                withAnimation(.easeInOut(duration: 2.0)) {
                    progress = 100
                }
            }) {
                Text("Show Progress")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func addPoints(for activity: String) {
        switch activity {
        case "meal":
            calories += 500 // Example calorie count for a meal
        case "bonus":
            points += 10
        case "workout":
            points += 15
        default:
            break
        }
        updateProgress()
    }

    private func updateProgress() {
        let progressFactor: CGFloat
        switch goal {
        case "lose":
            progressFactor = 40.0 / weightLossGoal // Adjust progress based on weight loss goal
            points = max(points - (calories / 100 * progressFactor), 0)
        case "gain":
            points += (calories / 100)
        case "maintain":
            points += 0
        default:
            progressFactor = 1.0
        }
        progress = min(points, 100)
    }
}

struct HealthProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HealthProgressView()
    }
}
