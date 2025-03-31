import SwiftUI

struct RecipeDetailView: View {
    var meal: String
    var calories: Double
    var tasteProfile: [String: Double]
    var relevance: Double
    var tastiness: Double
    var recipeInstructions: String

    var body: some View {
        ScrollView {
            VStack {
                Text(meal)
                    .font(.largeTitle)
                    .padding()

                Text("\(calories, specifier: "%.0f") calories")
                    .font(.title2)
                    .padding()

                Text("Taste Profile")
                    .font(.title2)
                    .padding(.top)

                ForEach(tasteProfile.keys.sorted(), id: \.self) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: CGFloat(tasteProfile[key]!) * geometry.size.width, height: 20)
                                .animation(.easeInOut(duration: 0.5))
                        }
                    }
                    .padding(.vertical, 5)
                }

                Text("Relevance")
                    .font(.title2)
                    .padding(.top)

                HStack {
                    Text("Relevance")
                    Spacer()
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: CGFloat(relevance) * geometry.size.width, height: 20)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding(.vertical, 5)

                Text("Tastiness")
                    .font(.title2)
                    .padding(.top)

                HStack {
                    Text("Tastiness")
                    Spacer()
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: CGFloat(tastiness) * geometry.size.width, height: 20)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding(.vertical, 5)

                Text("Recipe Instructions")
                    .font(.title2)
                    .padding(.top)

                Text(recipeInstructions)
                    .padding()

                Spacer()
            }
            .padding()
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(
            meal: "Sample Meal",
            calories: 600,
            tasteProfile: ["Sour": 0.3, "Sweet": 0.5, "Savory": 0.7],
            relevance: 0.8,
            tastiness: 0.9,
            recipeInstructions: "1. Preheat the oven to 350°F (175°C).\n2. Mix all ingredients in a bowl.\n3. Pour the mixture into a baking dish.\n4. Bake for 30 minutes or until golden brown."
        )
    }
}