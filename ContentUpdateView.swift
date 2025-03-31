import SwiftUI

struct ContentUpdateView: View {
    @State private var contentUpdate: ContentUpdate?

    var body: some View {
        VStack {
            Text("New Content")
                .font(.largeTitle)
                .padding()

            if let contentUpdate = contentUpdate {
                List {
                    Section(header: Text("New Workouts")) {
                        ForEach(contentUpdate.newWorkouts, id: \.self) { workout in
                            Text(workout)
                        }
                    }

                    Section(header: Text("New Meal Plans")) {
                        ForEach(contentUpdate.newMealPlans, id: \.self) { mealPlan in
                            Text(mealPlan)
                        }
                    }

                    Section(header: Text("New Challenges")) {
                        ForEach(contentUpdate.newChallenges, id: \.self) { challenge in
                            Text(challenge)
                        }
                    }
                }
            } else {
                Text("Fetching new content...")
                    .onAppear(perform: fetchNewContent)
            }
        }
        .padding()
    }

    private func fetchNewContent() {
        ContentUpdateManager.shared.fetchNewContent { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contentUpdate):
                    self.contentUpdate = contentUpdate
                case .failure(let error):
                    print("Failed to fetch new content: \(error)")
                }
            }
        }
    }
}

struct ContentUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ContentUpdateView()
    }
}