import SwiftUI

struct WorkoutView: View {
    @State private var isDevicePaired = false
    @State private var workoutCompleted = false

    var body: some View {
        VStack {
            if isDevicePaired {
                HealthProgressView()
            } else {
                DevicePairingView()
                    .onAppear {
                        // Simulate device pairing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isDevicePaired = true
                            }
                        }
                    }
            }

            Button(action: {
                // Logic to complete the workout
                workoutCompleted = true
            }) {
                Text("Complete Workout")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: WorkoutResultsView(), isActive: $workoutCompleted) {
                EmptyView()
            }
        }
        .padding()
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}