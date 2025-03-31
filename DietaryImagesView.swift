import SwiftUI

struct DietaryImagesView: View {
    let dietaryImages: [String] // Array of image names or URLs

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(dietaryImages, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationTitle("Dietary Images")
        }
    }
}

struct DietaryImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DietaryImagesView(dietaryImages: ["image1", "image2", "image3"])
    }
}

import SwiftUI

// Model for meal data
struct MealData: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let calories: Double
    let ingredients: [String]
    let instructions: [String]
    let category: MealCategory
    
    enum MealCategory: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snack = "Snack"
    }
}

struct DietaryImagesView: View {
    @State private var selectedMeal: MealData?
    @State private var showingRecipe = false
    @State private var filterCategory: MealData.MealCategory?
    @State private var progressData: [Double] = [250, 350, 400, 300, 450] // Sample progress data
    
    // Sample meal data with images and recipes
    let meals: [MealData] = [
        // Breakfast options
        MealData(
            name: "Avocado Toast with Poached Egg",
            imageName: "avocado_toast",
            calories: 250,
            ingredients: [
                "1 slice whole grain bread",
                "1/2 ripe avocado",
                "1 large egg",
                "Red pepper flakes, salt, and pepper to taste",
                "Optional: microgreens, cherry tomatoes, lemon juice"
            ],
            instructions: [
                "Toast bread until golden brown.",
                "Mash avocado and spread on toast.",
                "Poach egg in simmering water for 3-4 minutes.",
                "Place egg on avocado toast.",
                "Season with salt, pepper, and red pepper flakes.",
                "Add optional toppings and serve immediately."
            ],
            category: .breakfast
        ),
        
        MealData(
            name: "Greek Yogurt Parfait",
            imageName: "yogurt_parfait",
            calories: 200,
            ingredients: [
                "1 cup Greek yogurt (0% or 2% fat)",
                "1/4 cup mixed berries (strawberries, blueberries, raspberries)",
                "2 tbsp low-sugar granola",
                "1 tsp honey or maple syrup",
                "Optional: chia seeds, flaxseeds, or sliced almonds"
            ],
            instructions: [
                "Layer half the yogurt in a glass or bowl.",
                "Add half the berries and granola.",
                "Repeat layers.",
                "Drizzle with honey and add optional toppings."
            ],
            category: .breakfast
        ),
        
        MealData(
            name: "Spinach and Mushroom Omelette",
            imageName: "spinach_omelette",
            calories: 300,
            ingredients: [
                "2 large eggs",
                "1 cup fresh spinach, chopped",
                "1/4 cup mushrooms, sliced",
                "1 tbsp feta cheese, crumbled",
                "1 tsp olive oil",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Whisk eggs in a bowl with salt and pepper.",
                "Heat oil in a non-stick pan over medium heat.",
                "Sauté mushrooms until golden, add spinach until wilted.",
                "Pour egg mixture over vegetables.",
                "Cook until edges set, then fold in half.",
                "Sprinkle with feta cheese before serving."
            ],
            category: .breakfast
        ),
        
        // Lunch options
        MealData(
            name: "Mediterranean Quinoa Bowl",
            imageName: "quinoa_bowl",
            calories: 350,
            ingredients: [
                "1/2 cup cooked quinoa",
                "1/4 cup chickpeas, rinsed and drained",
                "1/4 cup cucumber, diced",
                "1/4 cup cherry tomatoes, halved",
                "2 tbsp red onion, diced",
                "2 tbsp feta cheese, crumbled",
                "1 tbsp olive oil",
                "1/2 tbsp lemon juice",
                "Fresh herbs (parsley, mint)",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Combine quinoa, chickpeas, cucumber, tomatoes, and onion in a bowl.",
                "Whisk together olive oil, lemon juice, salt, and pepper.",
                "Drizzle dressing over the bowl.",
                "Top with feta cheese and fresh herbs."
            ],
            category: .lunch
        ),
        
        MealData(
            name: "Grilled Chicken and Avocado Wrap",
            imageName: "chicken_wrap",
            calories: 400,
            ingredients: [
                "4 oz grilled chicken breast, sliced",
                "1 whole wheat tortilla",
                "1/4 avocado, sliced",
                "1/4 cup mixed greens",
                "2 tbsp Greek yogurt",
                "1 tsp lime juice",
                "1/4 tsp cumin",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Mix Greek yogurt with lime juice, cumin, salt, and pepper.",
                "Spread mixture on tortilla.",
                "Layer chicken, avocado, and mixed greens.",
                "Roll tightly and cut in half."
            ],
            category: .lunch
        ),
        
        MealData(
            name: "Salmon Poke Bowl",
            imageName: "poke_bowl",
            calories: 450,
            ingredients: [
                "4 oz sushi-grade salmon, cubed",
                "1/2 cup cooked brown rice",
                "1/4 cup cucumber, diced",
                "1/4 cup edamame, shelled",
                "1/4 avocado, sliced",
                "1 tbsp soy sauce",
                "1 tsp sesame oil",
                "1 tsp rice vinegar",
                "1 tsp sesame seeds",
                "Optional: seaweed strips, pickled ginger"
            ],
            instructions: [
                "Arrange rice in a bowl.",
                "Combine soy sauce, sesame oil, and rice vinegar.",
                "Toss salmon in half the sauce mixture.",
                "Arrange salmon, cucumber, edamame, and avocado over rice.",
                "Drizzle with remaining sauce.",
                "Sprinkle with sesame seeds and optional toppings."
            ],
            category: .lunch
        ),
        
        // Dinner options
        MealData(
            name: "Herb-Roasted Chicken with Vegetables",
            imageName: "roasted_chicken",
            calories: 400,
            ingredients: [
                "5 oz chicken breast",
                "1 cup mixed vegetables (carrots, brussels sprouts, bell peppers)",
                "1 tbsp olive oil",
                "1 tsp dried herbs (rosemary, thyme, oregano)",
                "2 garlic cloves, minced",
                "Salt and pepper to taste",
                "Lemon wedges for serving"
            ],
            instructions: [
                "Preheat oven to 425°F (220°C).",
                "Toss vegetables with half the oil, garlic, and herbs.",
                "Season chicken with remaining oil, herbs, salt, and pepper.",
                "Place chicken and vegetables on a baking sheet.",
                "Roast for 20-25 minutes until chicken is cooked through.",
                "Serve with lemon wedges."
            ],
            category: .dinner
        ),
        
        MealData(
            name: "Shrimp and Vegetable Stir-Fry",
            imageName: "shrimp_stirfry",
            calories: 350,
            ingredients: [
                "4 oz shrimp, peeled and deveined",
                "1 cup mixed vegetables (broccoli, snap peas, bell peppers, carrots)",
                "1/2 cup brown rice, cooked",
                "1 tbsp low-sodium soy sauce",
                "1 tsp sesame oil",
                "1 tsp ginger, minced",
                "1 garlic clove, minced",
                "1 tsp cornstarch mixed with 1 tbsp water",
                "Green onions for garnish"
            ],
            instructions: [
                "Heat oil in a wok or large pan over high heat.",
                "Add ginger and garlic, stir for 30 seconds.",
                "Add vegetables, stir-fry for 3-4 minutes.",
                "Add shrimp, cook until pink (2-3 minutes).",
                "Add soy sauce and cornstarch mixture.",
                "Stir until sauce thickens.",
                "Serve over brown rice, garnished with green onions."
            ],
            category: .dinner
        ),
        
        MealData(
            name: "Vegetarian Lentil Curry",
            imageName: "lentil_curry",
            calories: 400,
            ingredients: [
                "1/2 cup red lentils, rinsed",
                "1/4 cup coconut milk",
                "1/2 cup mixed vegetables (spinach, cauliflower, carrots)",
                "1/2 small onion, diced",
                "1 garlic clove, minced",
                "1 tsp ginger, minced",
                "1 tbsp curry powder",
                "1/4 tsp turmeric",
                "1/4 cup vegetable broth",
                "Fresh cilantro for garnish",
                "1/3 cup cooked brown rice"
            ],
            instructions: [
                "Sauté onion, garlic, and ginger until fragrant.",
                "Add curry powder and turmeric, stir for 30 seconds.",
                "Add lentils, vegetables, and broth.",
                "Simmer for 15-20 minutes until lentils are tender.",
                "Stir in coconut milk and heat through.",
                "Serve over brown rice, garnished with cilantro."
            ],
            category: .dinner
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Category filter buttons
                HStack {
                    ForEach([nil] + [MealData.MealCategory.breakfast, .lunch, .dinner], id: \.self) { category in
                        Button(action: {
                            filterCategory = category
                        }) {
                            Text(category?.rawValue ?? "All")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(filterCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(filterCategory == category ? .white : .primary)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Meal grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                        ForEach(filteredMeals) { meal in
                            MealCard(meal: meal)
                                .onTapGesture {
                                    selectedMeal = meal
                                    showingRecipe = true
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Meal Gallery")
            .sheet(isPresented: $showingRecipe) {
                if let meal = selectedMeal {
                    MealDetailView(meal: meal, progressData: $progressData)
                }
            }
        }
    }
    
    var filteredMeals: [MealData] {
        if let category = filterCategory {
            return meals.filter { $0.category == category }
        } else {
            return meals
        }
    }
}

struct MealCard: View {
    let meal: MealData
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(meal.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .cornerRadius(10)
            
            Text(meal.name)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(2)
                .padding(.horizontal, 8)
            
            Text("\(Int(meal.calories)) calories")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct MealDetailView: View {
    let meal: MealData
    @Binding var progressData: [Double]
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddToProgressAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 1. HERO IMAGE
                Image(meal.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
                // 2. RECIPE DETAILS
                VStack(alignment: .leading, spacing: 16) {
                    // Title and calories
                    VStack(alignment: .leading, spacing: 8) {
                        Text(meal.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(Int(meal.calories)) calories • \(meal.category.rawValue)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            showAddToProgressAlert = true
                        }) {
                            Text("Add to Today's Progress")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showAddToProgressAlert) {
                            Alert(
                                title: Text("Add to Progress"),
                                message: Text("Add \(meal.name) (\(Int(meal.calories)) calories) to your daily progress?"),
                                primaryButton: .default(Text("Add")) {
                                    progressData.append(meal.calories)
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    
                    Divider()
                    
                    // Ingredients
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.headline)
                        
                        ForEach(meal.ingredients, id: \.self) { ingredient in
                            HStack(alignment: .top) {
                                Text("•")
                                    .foregroundColor(.blue)
                                Text(ingredient)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Instructions
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.headline)
                        
                        ForEach(Array(meal.instructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top) {
                                Text("\(index + 1).")
                                    .foregroundColor(.blue)
                                    .frame(width: 25, alignment: .leading)
                                Text(instruction)
                            }
                            .padding(.bottom, 4)
                        }
                    }
                    
                    Divider()
                    
                    // 3. PROGRESS GRAPH
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Progress")
                            .font(.headline)
                        
                        // Your existing GoalTrackingGraphView
                        GoalTrackingGraphView(progressData: $progressData, goal: 2000.0)
                            .frame(height: 200)
                            .padding(.vertical)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                }
            }
        }
    }
}

// This is a placeholder for your existing GoalTrackingGraphView
// Replace this with your actual implementation
struct GoalTrackingGraphView: View {
    @Binding var progressData: [Double]
    let goal: Double
    
    var body: some View {
        VStack {
            Text("Daily Calorie Progress")
                .font(.headline)
            
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(progressData.indices, id: \.self) { index in
                    VStack {
                        Text("\(Int(progressData[index]))")
                            .font(.caption)
                            .rotationEffect(.degrees(-90))
                            .offset(y: -10)
                        
                        Rectangle()
                            .fill(progressData[index] > goal ? Color.red : Color.blue)
                            .frame(width: 30, height: CGFloat(progressData[index] / goal * 150))
                        
                        Text("Day \(index + 1)")
                            .font(.caption)
                    }
                }
            }
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 2)
            
            Text("Goal: \(Int(goal)) calories")
                .font(.caption)
                .padding(.top, 5)
        }
    }
}

struct DietaryImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DietaryImagesView()
    }
}
