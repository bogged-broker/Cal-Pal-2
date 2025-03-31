import SwiftUI

struct ProgressAnalyticsView: View {
    @Binding var progressData: [Double]
    var goal: Double

    var body: some View {
        VStack {
            Text("Progress Analytics")
                .font(.largeTitle)
                .padding()

            // Total calories burned
            Text("Total Calories Burned: \(progressData.reduce(0, +), specifier: "%.0f")")
                .font(.headline)
                .padding()

            // Average calories burned per day
            Text("Average Calories Burned per Day: \(progressData.isEmpty ? 0 : progressData.reduce(0, +) / Double(progressData.count), specifier: "%.0f")")
                .font(.headline)
                .padding()

            // Days to reach goal
            Text("Days to Reach Goal: \(goal / (progressData.isEmpty ? 1 : progressData.reduce(0, +) / Double(progressData.count)), specifier: "%.0f")")
                .font(.headline)
                .padding()

            // Progress over time
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let stepWidth = width / CGFloat(progressData.count - 1)
                    let stepHeight = height / CGFloat(goal)

                    path.move(to: CGPoint(x: 0, y: height - CGFloat(progressData[0]) * stepHeight))

                    for index in 1..<progressData.count {
                        let x = CGFloat(index) * stepWidth
                        let y = height - CGFloat(progressData[index]) * stepHeight
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
            }
            .padding()
        }
    }
}

struct ProgressAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressAnalyticsView(progressData: .constant([100, 200, 300, 400]), goal: 2000)
    }
}