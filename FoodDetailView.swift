import SwiftUI

struct FoodDetailView: View {
    var food: String
    var image: String
    var relevance: Double
    var tastiness: Double
    var healthBonus: Double

    var body: some View {
        VStack {
            Text(food)
                .font(.largeTitle)
                .padding()

            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            Text("Food Attributes")
                .font(.title)
                .padding()

            FoodAttributesGraph(relevance: relevance, tastiness: tastiness, healthBonus: healthBonus)
                .frame(height: 200)
                .padding()

            Spacer()
        }
        .padding()
    }
}

struct FoodAttributesGraph: View {
    var relevance: Double
    var tastiness: Double
    var healthBonus: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("Relevance")
            ProgressBar(value: relevance, color: .green)
            Text("Tastiness")
            ProgressBar(value: tastiness, color: .green)
            Text("Health Bonus")
            ProgressBar(value: healthBonus, color: .green)
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

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: "Oatmeal with fruits", image: "oatmeal", relevance: 0.8, tastiness: 0.9, healthBonus: 0.7)
    }
}