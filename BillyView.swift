import SwiftUI
import GoalProgressView

struct BillyView: View {
    @State private var showGoalProgress = false
    @State private var progressData: [ActivityType: Double] = [:]
    var activity: ActivityType
    var message: String

    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .padding()
            // Add random animations here
            if activity == .progress {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(Double.random(in: 0...360)))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                Text("Keep pushing forward!")
                    .font(.subheadline)
                    .padding()
            } else if activity == .meal {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaleEffect(1.5)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                Text("Bon appétit!")
                    .font(.subheadline)
                    .padding()
                // Trigger random activity and update goal progress
                triggerRandomActivity()
                // Navigate to goal progress graph after animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showGoalProgress = true
                }
            } else {
                triggerRandomActivity()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showGoalProgress = true
                }
            }
        }
        .fullScreenCover(isPresented: $showGoalProgress) {
            GoalProgressView(progressData: $progressData, activity: activity)
        }
    }

    func triggerRandomActivity() {
        let commonActivities: [ActivityType] = [.pushups, .cycling, .protein, .flexing]
        let rareActivities: [ActivityType] = [.flying, .impersonating, .celebrate]
        
        let randomActivity: ActivityType
        if Bool.random() {
            randomActivity = commonActivities.randomElement()!
        } else {
            randomActivity = rareActivities.randomElement()!
        }
        
        // Update goal progress chart and display message
        updateGoalProgress(for: randomActivity)
    }

    func updateGoalProgress(for activity: ActivityType) {
        // Logic to update goal progress chart
        // Display a text message with smooth animation based on the activity
        // This is a placeholder for the actual implementation
        progressData[activity, default: 0.0] += 0.1
        print("Updated goal progress for \(activity)")
    }
}

struct GoalProgressView: View {
    @Binding var progressData: [ActivityType: Double]
    var activity: ActivityType
    @State private var showAnimation = true

    var body: some View {
        VStack {
            Text("Goal Progress")
                .font(.largeTitle)
                .padding()
            // Smooth animation of the progress graph updating
            ForEach(ActivityType.allCases, id: \.self) { activity in
                ProgressView(value: progressData[activity, default: 0.0])
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                    .animation(.easeInOut(duration: 1))
            }
            if showAnimation {
                getActivityAnimation(for: activity)
                    .padding()
            }
            // ...additional UI elements...
        }
        .onTapGesture {
            showAnimation = false
        }
    }

    func getActivityAnimation(for activity: ActivityType) -> some View {
        switch activity {
        case .progress:
            return AnyView(
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(Double.random(in: 0...360)))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            )
        case .meal:
            return AnyView(
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaleEffect(1.5)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            )
        case .workout:
            return AnyView(
                Image(systemName: "figure.walk")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: -10)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            )
        case .bonus:
            return AnyView(
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(15))
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            )
        case .relax:
            return AnyView(
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(0.5)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
            )
        case .celebrate:
            return AnyView(
                Image(systemName: "party.popper.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaleEffect(1.2)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
            )
        case .pushups:
            return AnyView(
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: -10)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            )
        case .cycling:
            return AnyView(
                Image(systemName: "bicycle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(360))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            )
        case .flying:
            return AnyView(
                Image(systemName: "airplane")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(10))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            )
        case .protein:
            return AnyView(
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaleEffect(1.2)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
            )
        case .flexing:
            return AnyView(
                Image(systemName: "figure.flexing")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaleEffect(1.2)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
            )
        case .impersonating:
            return AnyView(
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(15))
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            )
        }
    }
}

enum ActivityType: CaseIterable {
    case progress
    case meal
    case workout
    case bonus
    case relax
    case celebrate
    case pushups
    case cycling
    case flying
    case protein
    case flexing
    case impersonating
}

struct BillyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BillyView(activity: .progress, message: "Keep going!")
            BillyView(activity: .meal, message: "Enjoy your meal!")
            BillyView(activity: .workout, message: "Great workout!")
            BillyView(activity: .bonus, message: "You're awesome!")
            BillyView(activity: .relax, message: "Relax and unwind!")
            BillyView(activity: .celebrate, message: "Time to celebrate!")
            BillyView(activity: .pushups, message: "Push it to the limit!")
            BillyView(activity: .cycling, message: "Keep pedaling!")
            BillyView(activity: .flying, message: "Soar high!")
            BillyView(activity: .protein, message: "Fuel up!")
            BillyView(activity: .flexing, message: "Show those muscles!")
            BillyView(activity: .impersonating, message: "We need you to workout!")
        }
    }
}