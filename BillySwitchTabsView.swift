import SwiftUI

struct BillySwitchTabsView: View {
    var body: some View {
        VStack {
            Image("billy_try_features")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Try out our other features!")
                .font(.title2)
                .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
