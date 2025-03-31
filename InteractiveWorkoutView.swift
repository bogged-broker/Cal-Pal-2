import SwiftUI

struct InteractiveWorkoutView: View {
    var workout: String
    var description: String
    var duration: Int // Duration in minutes

    var body: some View {
        VStack {
            Text(workout)
                .font(.largeTitle)
                .padding()

            Text(description)
                .font(.body)
                .padding()

            Text("Duration: \(duration) minutes")
                .font(.headline)
                .padding()

            Button(action: {
                // Start workout logic
            }) {
                Text("Start Workout")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Add interactive elements like animations or progress tracking
            Image("workout_animation")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
        }
        .padding()
    }
}

struct InteractiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveWorkoutView(workout: "Running", description: "A great cardio workout to improve your endurance.", duration: 30)
    }
}