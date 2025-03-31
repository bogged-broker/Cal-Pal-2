import SwiftUI

struct BonusSectionView: View {
    var onComplete: (Double) -> Void

    var body: some View {
        VStack {
            Text("Bonus Section")
                .font(.largeTitle)
                .padding()

            Button(action: {
                // Simulate completing a bonus section and returning a calorie value
                let bonusCalories = Double.random(in: 50...200)
                withAnimation {
                    onComplete(bonusCalories)
                }
            }) {
                Text("Complete Bonus")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct BonusSectionView_Previews: PreviewProvider {
    static var previews: some View {
        BonusSectionView { _ in }
    }
}