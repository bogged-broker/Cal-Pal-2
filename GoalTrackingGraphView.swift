import SwiftUI
import Charts

struct GoalTrackingGraphView: View {
    @Binding var progressData: [Double]
    @Binding var sleepData: [Double] // New binding for sleep data
    var goal: Double
    @State private var pointPosition: CGFloat = 0.0
    @State private var pointColor: Color = .gray
    @State private var isAnimating: Bool = true
    @State private var selectedIndex: Int = 0
    @State private var showDetails: Bool = false
    @State private var points: Int = 0 // New property to track points
    @State private var pastActivities: [Activity] = [] // New property to track past activities

    var body: some View {
        VStack {
            Text("Health Progress Goal Graph")
                .font(.largeTitle)
                .padding()

            Text("Points: \(points)") // Display points
                .font(.title)
                .padding()

            BillyView(activity: .progress, message: "Look at how far you've gone!")
                .onAppear {
                    startBillyAnimation()
                    fetchPastUserData() // Fetch past user data on appear
                }

            // New section for sleep tracking
            Text("Sleep Tracking")
                .font(.headline)
                .padding()

            if sleepData.isEmpty {
                Text("No sleep data available. Set up timers and alarms for sleep tracking.")
                    .font(.subheadline)
                    .padding()
            } else {
                ProgressView(value: sleepData.last ?? 0, total: 8) // Assuming 8 hours as the goal
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                Text("Last night's sleep: \(sleepData.last ?? 0, specifier: "%.1f") hours")
                    .font(.subheadline)
                    .padding()
            }

            GoalProgressView(progressData: $progressData, goal: goal)
                .animation(.easeInOut(duration: 1.0), value: progressData)

            GeometryReader { geometry in
                ZStack {
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
                    .stroke(Color.green, lineWidth: 2)
                    .animation(.easeInOut(duration: 1.0), value: progressData)

                    Circle()
                        .fill(pointColor)
                        .frame(width: 10, height: 10)
                        .position(x: pointPosition, y: geometry.size.height / 2)
                        .gesture(DragGesture()
                            .onChanged { value in
                                let width = geometry.size.width
                                let stepWidth = width / CGFloat(progressData.count - 1)
                                selectedIndex = min(max(Int(value.location.x / stepWidth), 0), progressData.count - 1)
                                pointPosition = CGFloat(selectedIndex) * stepWidth
                                showDetails = true
                            }
                            .onEnded { _ in
                                showDetails = false
                            }
                        )
                        .onAppear {
                            animatePoint(geometry: geometry)
                        }

                    if showDetails {
                        VStack {
                            Text("Time: \(selectedIndex)")
                            Text("Activity: \(getActivity(at: selectedIndex))")
                            Text("Calories: \(getCalories(at: selectedIndex))")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .position(x: pointPosition, y: geometry.size.height / 2 - 50)
                    }
                }
            }
            .padding()

            // Additional analytics
            VStack {
                Text("Total Calories Burned: \(progressData.reduce(0, +), specifier: "%.0f")")
                    .font(.headline)
                    .padding()

                Text("Average Calories Burned per Day: \(progressData.isEmpty ? 0 : progressData.reduce(0, +) / Double(progressData.count), specifier: "%.0f")")
                    .font(.headline)
                    .padding()

                Text("Days to Reach Goal: \(goal / (progressData.isEmpty ? 1 : progressData.reduce(0, +) / Double(progressData.count)), specifier: "%.0f")")
                    .font(.headline)
                    .padding()
            }

            BillyProgressView(progressData: $progressData, goal: goal)
        }
        .onChange(of: progressData) { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                // Trigger animation when progressData changes
                updatePoints() // Update points when progressData changes
            }
        }
        .onDisappear {
            isAnimating = false
        }
    }

    func addProgress(value: Double) {
        withAnimation(.easeInOut(duration: 1.0)) {
            progressData.append(value)
            updatePoints() // Update points when new progress is added
        }
    }

    private func animatePoint(geometry: GeometryProxy) {
        guard isAnimating else { return }
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            pointPosition = geometry.size.width
            pointColor = .black
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                pointPosition = 0
                pointColor = .gray
            }
        }
    }

    private func startBillyAnimation() {
        // Logic to start BillyView animation
    }

    private func getActivity(at index: Int) -> String {
        // Logic to get activity at the given index
        return "Sample Activity"
    }

    private func getCalories(at index: Int) -> Int {
        // Logic to get calories at the given index
        return 100
    }

    private func updatePoints() {
        // Logic to update points based on progressData
        points = progressData.reduce(0) { $0 + Int($1) }
    }

    private func fetchPastUserData() {
        // Logic to fetch past user data and update progressData and pastActivities
        // Example:
        // pastActivities = fetchFromDataSource()
        // progressData = pastActivities.map { $0.progress }
        updatePoints() // Update points after fetching data
    }
}

struct Activity {
    var progress: Double
    var type: String
    var calories: Int
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
        UserDetailView(user: UserModel(id: UUID(), name: "Alice", points: 1200, workouts: 500, bonuses: 300, meals: 200, recommended: 200, isNew: false, isOnStreak: true, streakLost: false, bonusWorkoutType: .weights, bonusWorkoutTimestamp: Date(), joinTimestamp: Date()))
    }
}