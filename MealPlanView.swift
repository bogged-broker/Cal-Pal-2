import SwiftUI
import UIKit
import UserNotifications

struct MealPlanView: View {
    @State private var userPreferences: UserModel?
    @State private var mealPlan: [(String, Double)] = [] // (Meal, Calories)
    @State private var recommendedMeals: [(String, Double)] = [] // (Meal, Calories)
    @State private var currentMealCategory: String = "Breakfast"
    @Binding var progressData: [Double]
    var onMealCheckedOff: (Double) -> Void
    @State private var selectedMeal: (String, Double)?
    @State private var showRecipeDetail = false
    @State private var showBuffGoldenBilly = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("Personalized Meal Plan")
                .font(.largeTitle)
                .padding()

            BillyView(activity: .eating, message: "Keep going with your meals!")

            if let userPreferences = userPreferences {
                Text("Current Meal: \(currentMealCategory)")
                    .font(.title2)
                    .padding()

                List {
                    Section(header: Text("Daily Dietary Meal Plan")) {
                        ForEach(Array(mealPlan.enumerated()), id: \.offset) { index, meal in
                            HStack {
                                Text("\(meal.0) - \(meal.1, specifier: "%.0f") calories")
                                Spacer()
                                Button(action: {
                                    // Show recipe detail
                                    selectedMeal = meal
                                    showRecipeDetail = true
                                }) {
                                    Text("View Recipe")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                Button(action: {
                                    // Check off meal
                                    onMealCheckedOff(meal.1)
                                    updateMealCheckOffs(meal: meal.0)
                                    mealPlan[index] = generateRandomMeal(calories: meal.1)
                                    moveToNextMealCategory()
                                }) {
                                    Text("Check Off")
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }

                    Section(header: Text("Recommended Meals")) {
                        ForEach(0..<recommendedMeals.count, id: \.self) { index in
                            HStack {
                                Text("\(recommendedMeals[index].0) - \(recommendedMeals[index].1, specifier: "%.0f") calories")
                                Spacer()
                                Button(action: {
                                    // Show recipe detail
                                    selectedMeal = recommendedMeals[index]
                                    showRecipeDetail = true
                                }) {
                                    Text("View Recipe")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                Button(action: {
                                    // Check off recommended meal
                                    onMealCheckedOff(recommendedMeals[index].1)
                                    updateMealCheckOffs(meal: recommendedMeals[index].0)
                                    recommendedMeals[index] = generateRandomMeal(calories: recommendedMeals[index].1)
                                    moveToNextMealCategory()
                                }) {
                                    Text("Check Off")
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            } else {
                Text("Loading...")
                    .onAppear(perform: loadUserPreferences)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .sheet(isPresented: $showRecipeDetail) {
            if let meal = selectedMeal {
                RecipeDetailView(
                    meal: meal.0,
                    calories: meal.1,
                    tasteProfile: ["Sour": 0.3, "Sweet": 0.5, "Savory": 0.7], // Example data
                    relevance: 0.8, // Example data
                    tastiness: 0.9, // Example data
                    recipeInstructions: getRecipeInstructions(for: meal.0) // Example data
                )
            }
        }
        .onAppear {
            startRandomTimer()
        }

        if showBuffGoldenBilly {
            BuffGoldenBillyView(message: "Complete a bonus workout to reach your goal even faster!")
                .transition(.scale)
        }
    }

    private func loadUserPreferences() {
        if let savedUser = UserDefaults.standard.object(forKey: "userPreferences") as? Data {
            if let loadedUser = try? JSONDecoder().decode(UserModel.self, from: savedUser) {
                userPreferences = loadedUser
                generateMealPlan()
                generateRecommendedMeals()
            }
        }
    }

    private func generateMealPlan() {
        guard let userPreferences = userPreferences else { return }
        let caloriesPerMeal = userPreferences.calorieGoal / Double(userPreferences.preferredMeals)
        mealPlan = (0..<userPreferences.preferredMeals).map { _ in generateRandomMeal(calories: caloriesPerMeal) }
    }

    private func generateRecommendedMeals() {
        guard let userPreferences = userPreferences else { return }
        let caloriesPerMeal = userPreferences.calorieGoal / Double(userPreferences.preferredMeals)
        let preferredMeals = getPreferredMeals(for: currentMealCategory)
        recommendedMeals = preferredMeals.map { ($0, caloriesPerMeal) }
    }

    private func getPreferredMeals(for category: String) -> [String] {
        guard let userPreferences = userPreferences else { return [] }
        switch category {
        case "Breakfast":
            return userPreferences.preferredBreakfast
        case "Lunch":
            return userPreferences.preferredLunch
        case "Dinner":
            return userPreferences.preferredDinner
        default:
            return []
        }
    }

    private func moveToNextMealCategory() {
        switch currentMealCategory {
        case "Breakfast":
            currentMealCategory = "Lunch"
        case "Lunch":
            currentMealCategory = "Dinner"
        case "Dinner":
            currentMealCategory = "Breakfast"
        default:
            currentMealCategory = "Breakfast"
        }
        generateRecommendedMeals()
    }

    private func updateMealCheckOffs(meal: String) {
        guard var userPreferences = userPreferences else { return }
        userPreferences.mealCheckOffs[meal, default: 0] += 1
        saveUserPreferences(userPreferences)
    }

    private func saveUserPreferences(_ user: UserModel) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "userPreferences")
        }
    }

    private func generateRandomMeal(calories: Double) -> (String, Double) {
        // Generate a random meal based on dietary preferences
        let meals = [
            ("Oatmeal with fruits", 300.0),
            ("Smoothie", 250.0),
            ("Grilled chicken salad", 400.0),
            ("Quinoa bowl", 350.0),
            ("Baked salmon with vegetables", 500.0),
            ("Stir-fried tofu", 300.0),
            ("Turkey sandwich", 350.0),
            ("Veggie wrap", 300.0),
            ("Chicken stir-fry", 400.0),
            ("Beef and broccoli", 450.0),
            ("Pasta with marinara sauce", 400.0),
            ("Shrimp tacos", 350.0),
            ("Greek yogurt with berries", 200.0),
            ("Avocado toast", 250.0),
            ("Protein shake", 200.0),
            ("Egg and spinach omelette", 300.0),
            ("Fruit salad", 150.0),
            ("Chicken and rice", 450.0),
            ("Vegetable soup", 200.0),
            ("Steak and potatoes", 600.0),
            ("Grilled cheese sandwich", 300.0),
            ("Caesar salad", 350.0),
            ("BBQ chicken pizza", 500.0),
            ("Fish and chips", 600.0),
            ("Pancakes with syrup", 400.0),
            ("Burrito bowl", 450.0),
            ("Lentil soup", 250.0),
            ("Tofu scramble", 300.0),
            ("Chicken Caesar wrap", 400.0),
            ("Beef tacos", 350.0),
            ("Veggie burger", 400.0),
            ("Spaghetti Bolognese", 500.0),
            ("Chicken curry", 450.0),
            ("Mushroom risotto", 400.0),
            ("Falafel wrap", 350.0),
            ("Stuffed bell peppers", 300.0),
            ("Chicken fajitas", 400.0),
            ("Salmon sushi", 350.0),
            ("Vegetable stir-fry", 300.0),
            ("Eggplant Parmesan", 400.0),
            ("Chicken Alfredo", 500.0),
            ("Beef stew", 450.0),
            ("Shrimp scampi", 400.0),
            ("Chicken quesadilla", 350.0),
            ("Vegetable lasagna", 400.0),
            ("Chicken Parmesan", 500.0),
            ("Beef burrito", 450.0),
            ("Vegetable curry", 350.0),
            ("Chicken noodle soup", 300.0),
            ("Beef chili", 400.0),
            ("Chicken pot pie", 450.0),
            ("Vegetable quiche", 350.0),
            ("Chicken enchiladas", 400.0),
            ("Beef stroganoff", 500.0),
            ("Vegetable paella", 350.0),
            ("Chicken tikka masala", 450.0),
            ("Beef kebabs", 400.0),
            ("Vegetable kebabs", 300.0),
            ("Chicken shawarma", 400.0),
            ("Beef gyros", 450.0),
            ("Vegetable biryani", 350.0),
            ("Chicken saag", 400.0),
            ("Beef rendang", 500.0),
            ("Vegetable pad thai", 450.0),
            ("Chicken satay", 400.0),
            ("Beef pho", 350.0),
            ("Vegetable ramen", 300.0),
            ("Chicken teriyaki", 400.0),
            ("Beef bulgogi", 450.0),
            ("Vegetable bibimbap", 350.0),
            ("Chicken katsu curry", 400.0),
            ("Beef sukiyaki", 500.0),
            ("Vegetable tempura", 450.0),
            ("Chicken yakitori", 400.0),
            ("Beef yakiniku", 350.0),
            ("Vegetable okonomiyaki", 300.0),
            ("Chicken karaage", 400.0),
            ("Beef tonkatsu", 450.0),
            ("Vegetable udon", 350.0),
            ("Chicken ramen", 400.0),
            ("Beef soba", 500.0),
            ("Vegetable sushi", 450.0),
            ("Chicken tempura", 400.0),
            ("Beef teriyaki", 350.0),
            ("Vegetable gyoza", 400.0),
            ("Chicken katsu", 450.0),
            ("Beef curry", 400.0),
            ("Vegetable korma", 350.0),
            ("Chicken tikka", 400.0),
            ("Beef biryani", 500.0),
            ("Vegetable saag", 450.0),
            ("Chicken vindaloo", 400.0),
            ("Beef madras", 350.0),
            ("Vegetable jalfrezi", 300.0),
            ("Chicken rogan josh", 400.0),
            ("Beef bhuna", 450.0),
            ("Vegetable dhansak", 350.0),
            ("Chicken butter masala", 400.0),
            ("Beef rogan josh", 500.0),
            ("Vegetable aloo gobi", 450.0),
            ("Beef stir-fry with white black wood ear mushrooms", 450.0)
        ]
        let filteredMeals = meals.filter { $0.1 <= calories }
        return filteredMeals.randomElement() ?? ("Meal", calories)
    }

    private func getRecipeInstructions(for meal: String) -> String {
        // Example recipe instructions for each meal
        let recipes = [
            "Oatmeal with fruits": "1. Cook oatmeal according to package instructions.\n2. Top with fresh fruits and a drizzle of honey.",
            "Smoothie": "1. Blend together your favorite fruits, yogurt, and a splash of milk until smooth.",
            "Grilled chicken salad": "1. Grill chicken breast until fully cooked.\n2. Toss with mixed greens, cherry tomatoes, and your favorite dressing.",
            "Quinoa bowl": "1. Cook quinoa according to package instructions.\n2. Top with roasted vegetables and a dollop of hummus.",
            "Baked salmon with vegetables": "1. Preheat oven to 375°F (190°C).\n2. Season salmon fillet and place on a baking sheet with vegetables.\n3. Bake for 20-25 minutes.",
            "Stir-fried tofu": "1. Press tofu to remove excess water.\n2. Stir-fry with your favorite vegetables and sauce.",
            "Turkey sandwich": "1. Layer turkey slices, lettuce, tomato, and avocado between two slices of whole grain bread.",
            "Veggie wrap": "1. Fill a whole wheat wrap with hummus, mixed greens, and sliced vegetables.",
            "Chicken stir-fry": "1. Stir-fry chicken breast with mixed vegetables and your favorite sauce.",
            "Beef and broccoli": "1. Stir-fry beef strips with broccoli and a savory sauce.",
            "Pasta with marinara sauce": "1. Cook pasta according to package instructions.\n2. Toss with marinara sauce and grated Parmesan cheese.",
            "Shrimp tacos": "1. Cook shrimp with taco seasoning.\n2. Serve in tortillas with cabbage slaw and avocado.",
            "Greek yogurt with berries": "1. Top Greek yogurt with fresh berries and a drizzle of honey.",
            "Avocado toast": "1. Mash avocado and spread on whole grain toast.\n2. Top with a sprinkle of salt and pepper.",
            "Protein shake": "1. Blend together protein powder, milk, and a banana until smooth.",
            "Egg and spinach omelette": "1. Whisk eggs and pour into a hot skillet.\n2. Add spinach and cook until eggs are set.",
            "Fruit salad": "1. Mix together your favorite fresh fruits.",
            "Chicken and rice": "1. Cook chicken breast and serve with steamed rice and vegetables.",
            "Vegetable soup": "1. Simmer mixed vegetables in broth until tender.",
            "Steak and potatoes": "1. Grill steak to desired doneness.\n2. Serve with roasted potatoes and a side salad.",
            "Grilled cheese sandwich": "1. Butter two slices of bread and place cheese between them.\n2. Grill until bread is golden and cheese is melted.",
            "Caesar salad": "1. Toss romaine lettuce with Caesar dressing, croutons, and Parmesan cheese.",
            "BBQ chicken pizza": "1. Spread BBQ sauce on pizza crust.\n2. Top with cooked chicken, red onion, and cheese.\n3. Bake until crust is golden.",
            "Fish and chips": "1. Coat fish fillets in batter and fry until golden.\n2. Serve with fries and tartar sauce.",
            "Pancakes with syrup": "1. Cook pancakes according to package instructions.\n2. Serve with maple syrup and butter.",
            "Burrito bowl": "1. Layer rice, beans, grilled chicken, and vegetables in a bowl.\n2. Top with salsa and guacamole.",
            "Lentil soup": "1. Simmer lentils with vegetables and broth until tender.",
            "Tofu scramble": "1. Crumble tofu and cook with vegetables and spices.",
            "Chicken Caesar wrap": "1. Fill a wrap with grilled chicken, romaine lettuce, and Caesar dressing.",
            "Beef tacos": "1. Cook ground beef with taco seasoning.\n2. Serve in tortillas with lettuce, cheese, and salsa.",
            "Veggie burger": "1. Cook veggie burger patty according to package instructions.\n2. Serve on a bun with lettuce, tomato, and avocado.",
            "Spaghetti Bolognese": "1. Cook spaghetti according to package instructions.\n2. Top with Bolognese sauce and grated Parmesan cheese.",
            "Chicken curry": "1. Cook chicken with curry sauce and serve with rice.",
            "Mushroom risotto": "1. Cook Arborio rice with broth and mushrooms until creamy.",
            "Falafel wrap": "1. Fill a wrap with falafel, hummus, and mixed greens.",
            "Stuffed bell peppers": "1. Fill bell peppers with a mixture of rice, ground beef, and vegetables.\n2. Bake until peppers are tender.",
            "Chicken fajitas": "1. Cook chicken with fajita seasoning and serve with tortillas and vegetables.",
            "Salmon sushi": "1. Roll sushi rice and salmon in nori sheets.\n2. Serve with soy sauce and wasabi.",
            "Vegetable stir-fry": "1. Stir-fry mixed vegetables with soy sauce and garlic.",
            "Eggplant Parmesan": "1. Bread and fry eggplant slices.\n2. Layer with marinara sauce and cheese.\n3. Bake until golden.",
            "Chicken Alfredo": "1. Cook pasta and toss with Alfredo sauce and grilled chicken.",
            "Beef stew": "1. Simmer beef with vegetables and broth until tender.",
            "Shrimp scampi": "1. Cook shrimp with garlic and butter.\n2. Serve over pasta.",
            "Chicken quesadilla": "1. Fill a tortilla with chicken and cheese.\n2. Cook until tortilla is golden and cheese is melted.",
            "Vegetable lasagna": "1. Layer lasagna noodles with ricotta, vegetables, and marinara sauce.\n2. Bake until bubbly.",
            "Chicken Parmesan": "1. Bread and fry chicken cutlets.\n2. Top with marinara sauce and cheese.\n3. Bake until golden.",
            "Beef burrito": "1. Fill a tortilla with beef, rice, beans, and cheese.\n2. Roll up and serve.",
            "Vegetable curry": "1. Cook mixed vegetables with curry sauce and serve with rice.",
            "Chicken noodle soup": "1. Simmer chicken, noodles, and vegetables in broth.",
            "Beef chili": "1. Cook ground beef with beans, tomatoes, and spices.",
            "Chicken pot pie": "1. Fill a pie crust with chicken and vegetable mixture.\n2. Top with another crust and bake until golden.",
            "Vegetable quiche": "1. Fill a pie crust with a mixture of eggs, cheese, and vegetables.\n2. Bake until set.",
            "Chicken enchiladas": "1. Fill tortillas with chicken and cheese.\n2. Roll up and place in a baking dish.\n3. Top with enchilada sauce and bake until bubbly.",
            "Beef stroganoff": "1. Cook beef with mushrooms and onions in a creamy sauce.\n2. Serve over egg noodles.",
            "Shrimp scampi": "1. Cook shrimp with garlic and butter.\n2. Serve over pasta.",
            "Chicken quesadilla": "1. Fill a tortilla with chicken and cheese.\n2. Cook until tortilla is golden and cheese is melted.",
            "Vegetable lasagna": "1. Layer lasagna noodles with ricotta, vegetables, and marinara sauce.\n2. Bake until bubbly.",
            "Chicken Parmesan": "1. Bread and fry chicken cutlets.\n2. Top with marinara sauce and cheese.\n3. Bake until golden.",
            "Beef burrito": "1. Fill a tortilla with beef, rice, beans, and cheese.\n2. Roll up and serve.",
            "Vegetable curry": "1. Cook mixed vegetables with curry sauce and serve with rice.",
            "Chicken noodle soup": "1. Simmer chicken, noodles, and vegetables in broth.",
            "Beef chili": "1. Cook ground beef with beans, tomatoes, and spices.",
            "Chicken pot pie": "1. Fill a pie crust with chicken and vegetable mixture.\n2. Top with another crust and bake until golden.",
            "Vegetable quiche": "1. Fill a pie crust with a mixture of eggs, cheese, and vegetables.\n2. Bake until set.",
            "Chicken enchiladas": "1. Fill tortillas with chicken and cheese.\n2. Roll up and place in a baking dish.\n3. Top with enchilada sauce and bake until bubbly.",
        ]
        return recipes[meal] ?? "Recipe not found."
    }

    private func startRandomTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 10...30), repeats: true) { _ in
            withAnimation {
                showBuffGoldenBilly = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showBuffGoldenBilly = false
                }
            }
        }
    }
}

struct MealPlanView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanView()
    }
}
