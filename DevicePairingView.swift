import SwiftUI

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

            NavigationLink(destination: WorkoutView()) {
                Text("Go to Workouts")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct DevicePairingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePairingView()
    }
}