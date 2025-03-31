import SwiftUI

struct BuffGoldenBillyView: View {
    var message: String

    var body: some View {
        VStack {
            Image("buff_golden_billy") // Replace with the actual image name
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(message)
                .font(.headline)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct BuffGoldenBillyView_Previews: PreviewProvider {
    static var previews: some View {
        BuffGoldenBillyView(message: "Complete a bonus workout to reach your goal even faster!")
    }
}