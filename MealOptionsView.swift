import SwiftUI
import UIKit
import UserNotifications

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]
    let foods = [
        ("Oatmeal with fruits", "oatmeal", 0.8, 0.9, 0.7),
        ("Smoothie", "smoothie", 0.7, 0.8, 0.6),
        ("Grilled chicken salad", "chicken_salad", 0.9, 0.9, 0.8),
        ("Pasta with tomato sauce", "pasta", 0.7, 0.8, 0.6),
        ("Vegetable stir-fry", "stir_fry", 0.8, 0.9, 0.7),
        ("Quinoa salad", "quinoa_salad", 0.9, 0.8, 0.8),
        ("Chicken curry", "chicken_curry", 0.8, 0.9, 0.7),
        ("Beef stew", "beef_stew", 0.7, 0.8, 0.6),
        ("Fish tacos", "fish_tacos", 0.9, 0.9, 0.8),
        ("Veggie burger", "veggie_burger", 0.8, 0.9, 0.7)
        // Add more foods as needed
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                List {
                    ForEach(foods, id: \.0) { food in
                        NavigationLink(destination: FoodDetailView(food: food.0, image: food.1, relevance: food.2, tastiness: food.3, healthBonus: food.4)) {
                            Text(food.0)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView()
    }
}
import SwiftUI
import UIKit
import UserNotifications

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]
    let calorieGoal: Double = 2000.0 // Example daily calorie goal
    let foods = [
        ("Oatmeal with fruits", "oatmeal", 0.8, 0.9, 0.7, 300),
        ("Smoothie", "smoothie", 0.7, 0.8, 0.6, 250),
        ("Grilled chicken salad", "chicken_salad", 0.9, 0.9, 0.8, 400),
        ("Pasta with tomato sauce", "pasta", 0.7, 0.8, 0.6, 350),
        ("Vegetable stir-fry", "stir_fry", 0.8, 0.9, 0.7, 300),
        ("Quinoa salad", "quinoa_salad", 0.9, 0.8, 0.8, 350),
        ("Chicken curry", "chicken_curry", 0.8, 0.9, 0.7, 450),
        ("Beef stew", "beef_stew", 0.7, 0.8, 0.6, 500),
        ("Fish tacos", "fish_tacos", 0.9, 0.9, 0.8, 300),
        ("Veggie burger", "veggie_burger", 0.8, 0.9, 0.7, 400)
        // Add more foods as needed
    ]

    var filteredFoods: [(String, String, Double, Double, Double, Int)] {
        let maxCaloriesPerMeal = calorieGoal / Double(selectedMeals)
        return foods.filter { $0.5 <= maxCaloriesPerMeal }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                List {
                    ForEach(filteredFoods, id: \.0) { food in
                        NavigationLink(destination: FoodDetailView(food: food.0, image: food.1, relevance: food.2, tastiness: food.3, healthBonus: food.4)) {
                            Text(food.0)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct FoodDetailView: View {
    let food: String
    let image: String
    let relevance: Double
    let tastiness: Double
    let healthBonus: Double

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Text(food)
                .font(.largeTitle)
                .padding()

            Text("Relevance: \(relevance, specifier: "%.1f")")
            Text("Tastiness: \(tastiness, specifier: "%.1f")")
            Text("Health Bonus: \(healthBonus, specifier: "%.1f")")

            Spacer()
        }
        .padding()
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView()
    }
}
import SwiftUI
import UIKit
import UserNotifications

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]
    let calorieGoal: Double // User's specific daily calorie goal
    let foods = [
        ("Oatmeal with fruits", "oatmeal", 0.8, 0.9, 0.7, 300),
        ("Smoothie", "smoothie", 0.7, 0.8, 0.6, 250),
        ("Grilled chicken salad", "chicken_salad", 0.9, 0.9, 0.8, 400),
        ("Pasta with tomato sauce", "pasta", 0.7, 0.8, 0.6, 350),
        ("Vegetable stir-fry", "stir_fry", 0.8, 0.9, 0.7, 300),
        ("Quinoa salad", "quinoa_salad", 0.9, 0.8, 0.8, 350),
        ("Chicken curry", "chicken_curry", 0.8, 0.9, 0.7, 450),
        ("Beef stew", "beef_stew", 0.7, 0.8, 0.6, 500),
        ("Fish tacos", "fish_tacos", 0.9, 0.9, 0.8, 300),
        ("Veggie burger", "veggie_burger", 0.8, 0.9, 0.7, 400)
        // Add more foods as needed
    ]

    var filteredFoods: [(String, String, Double, Double, Double, Int)] {
        let maxCaloriesPerMeal = calorieGoal / Double(selectedMeals)
        return foods.filter { $0.5 <= maxCaloriesPerMeal }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                List {
                    ForEach(filteredFoods, id: \.0) { food in
                        NavigationLink(destination: FoodDetailView(food: food.0, image: food.1, relevance: food.2, tastiness: food.3, healthBonus: food.4)) {
                            Text(food.0)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct FoodDetailView: View {
    let food: String
    let image: String
    let relevance: Double
    let tastiness: Double
    let healthBonus: Double

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Text(food)
                .font(.largeTitle)
                .padding()

            Text("Relevance: \(relevance, specifier: "%.1f")")
            Text("Tastiness: \(tastiness, specifier: "%.1f")")
            Text("Health Bonus: \(healthBonus, specifier: "%.1f")")

            Spacer()
        }
        .padding()
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView(calorieGoal: 2000.0) // Example preview with a calorie goal
    }
}
import SwiftUI
import UIKit
import UserNotifications

struct User {
    var weight: Double // in kg
    var height: Double // in cm
    var age: Int
    var gender: String // "male" or "female"
    var activityLevel: String // "sedentary", "light", "moderate", "active", "very active"
    var goal: String // "lose", "maintain", "gain"
}

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]
    let user: User
    let foods = [
        ("Oatmeal with fruits", "oatmeal", 0.8, 0.9, 0.7, 300),
        ("Smoothie", "smoothie", 0.7, 0.8, 0.6, 250),
        ("Grilled chicken salad", "chicken_salad", 0.9, 0.9, 0.8, 400),
        ("Pasta with tomato sauce", "pasta", 0.7, 0.8, 0.6, 350),
        ("Vegetable stir-fry", "stir_fry", 0.8, 0.9, 0.7, 300),
        ("Quinoa salad", "quinoa_salad", 0.9, 0.8, 0.8, 350),
        ("Chicken curry", "chicken_curry", 0.8, 0.9, 0.7, 450),
        ("Beef stew", "beef_stew", 0.7, 0.8, 0.6, 500),
        ("Fish tacos", "fish_tacos", 0.9, 0.9, 0.8, 300),
        ("Veggie burger", "veggie_burger", 0.8, 0.9, 0.7, 400)
        // Add more foods as needed
    ]

    var dailyCalorieNeeds: Double {
        let bmr: Double
        if user.gender == "male" {
            bmr = 88.362 + (13.397 * user.weight) + (4.799 * user.height) - (5.677 * Double(user.age))
        } else {
            bmr = 447.593 + (9.247 * user.weight) + (3.098 * user.height) - (4.330 * Double(user.age))
        }

        let activityMultiplier: Double
        switch user.activityLevel {
        case "sedentary":
            activityMultiplier = 1.2
        case "light":
            activityMultiplier = 1.375
        case "moderate":
            activityMultiplier = 1.55
        case "active":
            activityMultiplier = 1.725
        case "very active":
            activityMultiplier = 1.9
        default:
            activityMultiplier = 1.2
        }

        var dailyCalories = bmr * activityMultiplier

        switch user.goal {
        case "lose":
            dailyCalories -= 500
        case "gain":
            dailyCalories += 500
        default:
            break
        }

        return dailyCalories
    }

    var filteredFoods: [(String, String, Double, Double, Double, Int)] {
        let maxCaloriesPerMeal = dailyCalorieNeeds / Double(selectedMeals)
        return foods.filter { $0.5 <= maxCaloriesPerMeal }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                List {
                    ForEach(filteredFoods, id: \.0) { food in
                        NavigationLink(destination: FoodDetailView(food: food.0, image: food.1, relevance: food.2, tastiness: food.3, healthBonus: food.4)) {
                            Text(food.0)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct FoodDetailView: View {
    let food: String
    let image: String
    let relevance: Double
    let tastiness: Double
    let healthBonus: Double

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Text(food)
                .font(.largeTitle)
                .padding()

            Text("Relevance: \(relevance, specifier: "%.1f")")
            Text("Tastiness: \(tastiness, specifier: "%.1f")")
            Text("Health Bonus: \(healthBonus, specifier: "%.1f")")

            Spacer()
        }
        .padding()
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView(user: User(weight: 70, height: 175, age: 25, gender: "male", activityLevel: "moderate", goal: "maintain"))
    }
}
struct ContentView: View {
    var body: some View {
        MealOptionsView(user: User(weight: 70, height: 175, age: 25, gender: "male", activityLevel: "moderate", goal: "maintain"))
    }
}
import SwiftUI
import UIKit
import UserNotifications

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView()
    }
}

struct DevicePairingView: View {
    var body: some View {
        VStack {
            Text("Pair Your Device")
                .font(.largeTitle)
                .padding()

            Text("Select your device to pair:")
                .font(.title2)
                .padding()

            List {
                Text("Garmin")
                Text("Fitbit")
                Text("Apple Watch")
                Text("Samsung Gear")
                Text("Polar")
                Text("Suunto")
                Text("Xiaomi Mi Band")
                Text("Huawei Watch")
                Text("Withings")
                Text("Amazfit")
                Text("Coros")
                Text("Wahoo")
                Text("Oura Ring")
                Text("Whoop Strap")
                // Add more devices as needed
            }

            Spacer()

            Text("Recipes")
                .font(.title)
                .padding()

            List {
                RecipeView(recipe: "Oatmeal with fruits", ingredients: ["Oats", "Fruits", "Milk"], steps: ["1. Cook oats", "2. Add fruits", "3. Pour milk"])
                RecipeView(recipe: "Smoothie", ingredients: ["Banana", "Berries", "Yogurt"], steps: ["1. Blend banana", "2. Add berries", "3. Mix with yogurt"])
                RecipeView(recipe: "Grilled chicken salad", ingredients: ["Chicken", "Lettuce", "Tomatoes"], steps: ["1. Grill chicken", "2. Chop lettuce", "3. Add tomatoes"])
                // Add more recipes as needed
            }

            Spacer()

            Text("Food Attributes")
                .font(.title)
                .padding()

            FoodAttributesGraph()
                .frame(height: 200)
                .padding()
        }
        .padding()
    }
}

struct RecipeView: View {
    var recipe: String
    var ingredients: [String]
    var steps: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe)
                .font(.headline)
            Text("Ingredients:")
                .font(.subheadline)
            ForEach(ingredients, id: \.self) { ingredient in
                Text("- \(ingredient)")
            }
            Text("Steps:")
                .font(.subheadline)
            ForEach(steps, id: \.self) { step in
                Text(step)
            }
        }
        .padding()
    }
}

struct FoodAttributesGraph: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Relevance")
            ProgressBar(value: 0.8, color: .green)
            Text("Tastiness")
            ProgressBar(value: 0.9, color: .green)
            Text("Health Bonus")
            ProgressBar(value: 0.7, color: .green)
            // Add more attributes as needed
        }
    }
}

struct ProgressBar: View {
    var value: Double
    var color: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(self.color)
                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}

struct DevicePairingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePairingView()
    }
}

class MainViewController: UIViewController {
    
    // MARK: - Properties
    @State private var progressData: [Double] = []
    private let goal: Double = 2000.0 // Example goal
    private let onboardingView = UIHostingController(rootView: OnboardingView(onComplete: handleOnboardingComplete))
    private let mealOptionsView = UIHostingController(rootView: MealOptionsView())
    private let dietaryImagesView = UIHostingController(rootView: DietaryImagesView())
    private let goalTrackingGraphView = UIHostingController(rootView: GoalTrackingGraphView(progressData: .constant([]), goal: 2000.0))
    private lazy var cameraView = UIHostingController(rootView: CameraView(onScanComplete: handleScanComplete))
    private lazy var workoutView = UIHostingController(rootView: WorkoutView(onDevicePairing: handleDevicePairing))
    private lazy var bonusSectionView = UIHostingController(rootView: BonusSectionView(onComplete: handleBonusComplete))
    private lazy var mealPlanView = UIHostingController(rootView: MealPlanView(progressData: $progressData, onMealCheckedOff: handleMealCheckedOff))
    private lazy var devicePairingView = UIHostingController(rootView: DevicePairingView())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        scheduleBonusNotification()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.backgroundColor = .white
        addChildView(onboardingView)
    }
    
    private func setupNavigation() {
        // Setup navigation logic between views
        // Example: Add buttons or gestures to switch between views
        let cameraButton = UIButton(type: .system)
        cameraButton.setTitle("Camera", for: .normal)
        cameraButton.addTarget(self, action: #selector(showCameraView), for: .touchUpInside)
        view.addSubview(cameraButton)
        // Set up constraints or frame for cameraButton
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        let workoutButton = UIButton(type: .system)
        workoutButton.setTitle("Workouts", for: .normal)
        workoutButton.addTarget(self, action: #selector(showWorkoutView), for: .touchUpInside)
        view.addSubview(workoutButton)
        // Set up constraints or frame for workoutButton
        workoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workoutButton.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -20)
        ])
        
        let bonusButton = UIButton(type: .system)
        bonusButton.setTitle("Bonus", for: .normal)
        bonusButton.addTarget(self, action: #selector(showBonusSectionView), for: .touchUpInside)
        view.addSubview(bonusButton)
        // Set up constraints or frame for bonusButton
        bonusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bonusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bonusButton.bottomAnchor.constraint(equalTo: workoutButton.topAnchor, constant: -20)
        ])
        
        let mealPlanButton = UIButton(type: .system)
        mealPlanButton.setTitle("Meal Plan", for: .normal)
        mealPlanButton.addTarget(self, action: #selector(showMealPlanView), for: .touchUpInside)
        view.addSubview(mealPlanButton)
        // Set up constraints or frame for mealPlanButton
        mealPlanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mealPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mealPlanButton.bottomAnchor.constraint(equalTo: bonusButton.topAnchor, constant: -20)
        ])
        
        let devicePairingButton = UIButton(type: .system)
        devicePairingButton.setTitle("Pair Device", for: .normal)
        devicePairingButton.addTarget(self, action: #selector(showDevicePairingView), for: .touchUpInside)
        view.addSubview(devicePairingButton)
        // Set up constraints or frame for devicePairingButton
        devicePairingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            devicePairingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            devicePairingButton.bottomAnchor.constraint(equalTo: mealPlanButton.topAnchor, constant: -20)
        ])
    }
    
    // MARK: - Helper Methods
    private func addChildView(_ childView: UIViewController) {
        addChild(childView)
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        // Set up constraints or frame for childView
        childView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.view.topAnchor.constraint(equalTo: view.topAnchor),
            childView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func showCameraView() {
        transitionToView(cameraView)
    }
    
    @objc private func showWorkoutView() {
        transitionToView(workoutView)
    }
    
    @objc private func showBonusSectionView() {
        transitionToView(bonusSectionView)
    }
     
    @objc private func showMealPlanView() {
        transitionToView(mealPlanView)
    }
    
    @objc private func showDevicePairingView() {
        transitionToView(devicePairingView)
    }
    
    private func handleScanComplete(calories: Double) {
        updateProgressData(with: calories)
        cameraView.dismiss(animated: true, completion: nil)
    }
    
    private func handleBonusComplete(calories: Double) {
        updateProgressData(with: calories)
        bonusSectionView.dismiss(animated: true, completion: nil)
    }
    
    private func handleMealCheckedOff(calories: Double) {
        updateProgressData(with: calories)
    }
    
    private func handleOnboardingComplete() {
        transitionToView(mealPlanView)
    }
    
    private func handleDevicePairing() {
        showDevicePairingView()
    }
    
    // Method to update progress data
    private func updateProgressData(with newValue: Double) {
        progressData.append(newValue)
        goalTrackingGraphView.rootView.progressData = progressData
    }
    
    // Method to schedule bonus notifications
    private func scheduleBonusNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Bonus Section Available"
        content.body = "Complete a bonus section to earn extra calories towards your goal!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 12 // 12 PM daily reminder

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "bonusReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Method to handle view transitions with smooth animations
    private func transitionToView(_ newView: UIViewController) {
        let currentView = children.last
        addChild(newView)
        newView.view.frame = view.bounds
        newView.view.alpha = 0
        view.addSubview(newView.view)
        
        UIView.animate(withDuration: 0.3, animations: {
            newView.view.alpha = 1
            currentView?.view.alpha = 0
        }) { _ in
            currentView?.willMove(toParent: nil)
            currentView?.view.removeFromSuperview()
            currentView?.removeFromParent()
            newView.didMove(toParent: self)
        }
    }
}
import SwiftUI
import UIKit
import UserNotifications

struct MealOptionsView: View {
    @State private var selectedMeals: Int = 1
    let mealOptions = [1, 2, 3, 4, 5]
    let foods = [
        ("Oatmeal with fruits", "oatmeal", 0.8, 0.9, 0.7),
        ("Smoothie", "smoothie", 0.7, 0.8, 0.6),
        ("Grilled chicken salad", "chicken_salad", 0.9, 0.9, 0.8)
        // Add more foods as needed
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Select Number of Meals")
                    .font(.largeTitle)
                    .padding()

                Picker("Meals", selection: $selectedMeals) {
                    ForEach(mealOptions, id: \.self) { option in
                        Text("\(option) Meal\(option > 1 ? "s" : "")").tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Placeholder for dietary preferences selection
                Text("Select Dietary Preferences")
                    .font(.headline)
                    .padding()

                // Add additional UI elements for dietary preferences here

                List {
                    ForEach(foods, id: \.0) { food in
                        NavigationLink(destination: FoodDetailView(food: food.0, image: food.1, relevance: food.2, tastiness: food.3, healthBonus: food.4)) {
                            Text(food.0)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Meal Options")
        }
    }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView()
    }
}