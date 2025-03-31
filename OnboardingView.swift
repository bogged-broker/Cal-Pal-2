import SwiftUI

struct AnimatedEmojiView: View {
    var emoji: String) -> Void
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0    @State private var gender: String = ""
ze: String = ""
    var body: some View {var goal: String = ""
        Text(emoji)yLevel: String = ""
            .font(.largeTitle)dMeals: Int = 3
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))calorieGoal: Double = 2000.0
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))Breakfast: [String] = []
            .onAppear {ivate var preferredLunch: [String] = []
                self.scale = 1.5State private var preferredDinner: [String] = []
                self.rotation = 360   @State private var wantsWorkouts: Bool = false
            }
    }
}

struct AnimatedEmojiView_Previews: PreviewProvider {           .font(.largeTitle)
    static var previews: some View {               .padding()



}    }        AnimatedEmojiView(emoji: "😊")
            Spacer()

            // Gender Selection
            Picker("Select Gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Other").tag("Other")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Size Selection
            Picker("Select Size", selection: $size) {
                Text("Small").tag("Small")
                Text("Medium").tag("Medium")
                Text("Large").tag("Large")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Goals Selection
            Picker("Select Goals", selection: $goal) {
                Text("Weight Loss").tag("Weight Loss")
                Text("Muscle Gain").tag("Muscle Gain")
                Text("Maintenance").tag("Maintenance")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Activity Level Selection
            Picker("Select Activity Level", selection: $activityLevel) {
                Text("Sedentary").tag("Sedentary")
                Text("Active").tag("Active")
                Text("Very Active").tag("Very Active")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Stepper("Preferred Meals: \(preferredMeals)", value: $preferredMeals, in: 1...6)
                .padding()

            TextField("Enter your calorie goal", value: $calorieGoal, formatter: NumberFormatter())
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Text("Select your preferred breakfast meals")
            MealSelectionView(selectedMeals: $preferredBreakfast)

            Text("Select your preferred lunch meals")
            MealSelectionView(selectedMeals: $preferredLunch)

            Text("Select your preferred dinner meals")
            MealSelectionView(selectedMeals: $preferredDinner)

            Toggle(isOn: $wantsWorkouts) {
                Text("Do you want workouts?")
            }
            .padding()

            Spacer()

            Button(action: {
                // Handle onboarding completion
                let user = UserModel(
                    gender: gender,
                    size: size,
                    goal: goal,
                    activityLevel: activityLevel,
                    preferredMeals: preferredMeals,
                    dietaryPreferences: dietaryPreferences,
                    calorieGoal: calorieGoal,
                    preferredBreakfast: preferredBreakfast,
                    preferredLunch: preferredLunch,
                    preferredDinner: preferredDinner,
                    mealCheckOffs: [:],
                    wantsWorkouts: wantsWorkouts
                )
                saveUserPreferences(user)
                onComplete()
            }) {
                Text("Get Started")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

        }
        .padding()
        .animation(.easeInOut, value: gender)
    }

    private func saveUserPreferences(_ user: UserModel) {
        // Save user preferences to UserDefaults or a database
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "userPreferences")
        }
    }
}

struct MealSelectionView: View {
    @Binding var selectedMeals: [String]
    let meals = ["Oatmeal", "Smoothie", "Grilled Chicken Salad", "Quinoa Bowl", "Baked Salmon", "Stir-fried Tofu", "Turkey Sandwich", "Veggie Wrap", "Chicken Stir-fry", "Beef and Broccoli"]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(meals, id: \.self) { meal in
                    VStack {
                        Image(meal) // Assuming you have images named after the meals
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        Text(meal)
                            .font(.caption)
                    }
                    .onTapGesture {
                        if selectedMeals.contains(meal) {
                            selectedMeals.removeAll { $0 == meal }
                        } else {
                            selectedMeals.append(meal)
                        }
                    }
                    .background(selectedMeals.contains(meal) ? Color.blue.opacity(0.3) : Color.clear)
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onComplete: {})
    }
}