import SwiftUI
import Charts // Import Swift Charts if available

struct ProgressGraphView: View {
    @State private var isGraphBouncing = false

    // Example data for the progress graph
    let progressData: [ProgressEntry] = [
        ProgressEntry(day: "Mon", value: 50),
        ProgressEntry(day: "Tue", value: 70),
        ProgressEntry(day: "Wed", value: 90),
        ProgressEntry(day: "Thu", value: 60),
        ProgressEntry(day: "Fri", value: 80),
        ProgressEntry(day: "Sat", value: 100),
        ProgressEntry(day: "Sun", value: 75)
    ]

    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()

            // Top Left: Calorie Burning for the Week
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Calories Burned")
                            .font(.headline)
                        Text("1500 kcal")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }

            // Top Middle: Projected Stats for Next Week
            VStack {
                Text("Projected Stats")
                    .font(.headline)
                Text("2000 kcal")
                    .font(.title)
                    .bold()
                    .padding(.top, 4)
                Spacer()
            }
            .padding(.top, 20)

            // Top Right: Heart Rate
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Heart Rate")
                            .font(.headline)
                        Text("75 bpm")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                }
                Spacer()
            }

            // Middle: Progress Analytics Graph
            VStack {
                Spacer()
                if #available(iOS 16.0, *) {
                    Chart(progressData) { entry in
                        LineMark(
                            x: .value("Day", entry.day),
                            y: .value("Value", entry.value)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(Color.blue)
                    }
                    .frame(height: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .scaleEffect(isGraphBouncing ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true),
                        value: isGraphBouncing
                    )
                    .onAppear {
                        isGraphBouncing = true
                    }
                } else {
                    Text("Graph not supported on this iOS version.")
                        .foregroundColor(.red)
                }
                Spacer()
            }

            // Bottom Left: Billy Working Out
            VStack {
                Spacer()
                HStack {
                    Image("billy_working_out") // Replace with your asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

struct ProgressEntry: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

struct ProgressGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressGraphView()
    }
}