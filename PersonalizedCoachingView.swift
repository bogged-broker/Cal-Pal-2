import SwiftUI

struct PersonalizedCoachingView: View {
    @State private var workoutPlan: String = "Loading..."
    @State private var mealSuggestion: String = "Loading..."

    var body: some View {
        VStack {
            Text("Personalized Coaching")
                .font(.largeTitle)
                .padding()

            Text("Workout Plan")
                .font(.headline)
                .padding(.top)
            Text(workoutPlan)
                .padding()

            Text("Meal Suggestion")
                .font(.headline)
                .padding(.top)
            Text(mealSuggestion)
                .padding()

            Button(action: {
                generatePersonalizedRecommendations()
            }) {
                Text("Get New Recommendations")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .onAppear {
            generatePersonalizedRecommendations()
        }
    }

    private func generatePersonalizedRecommendations() {
        // Logic to generate personalized workout plan and meal suggestion
        workoutPlan = "30-minute cardio workout"
        mealSuggestion = "Grilled chicken salad with quinoa"
    }
}

struct PersonalizedCoachingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizedCoachingView()
    }
}