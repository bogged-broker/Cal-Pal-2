import SwiftUI

struct InteractiveMealPlanView: View {
    var meal: String
    var ingredients: [String]
    var instructions: String

    var body: some View {
        VStack {
            Text(meal)
                .font(.largeTitle)
                .padding()

            Text("Ingredients")
                .font(.headline)
                .padding()

            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
                    .font(.body)
                    .padding(.horizontal)
            }

            Text("Instructions")
                .font(.headline)
                .padding()

            Text(instructions)
                .font(.body)
                .padding()

            Button(action: {
                // Mark meal as completed
            }) {
                Text("Mark as Completed")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Add interactive elements like animations or progress tracking
            Image("meal_animation")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
        }
        .padding()
    }
}

struct InteractiveMealPlanView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveMealPlanView(meal: "Chicken Salad", ingredients: ["Chicken", "Lettuce", "Tomatoes", "Cucumbers"], instructions: "1. Cook the chicken.\n2. Chop the vegetables.\n3. Mix everything together.")
    }
}