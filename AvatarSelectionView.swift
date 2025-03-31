import SwiftUI
// Add Make Your Own Custom Avatars Here So You Can Mix And Match
struct AvatarSelectionView: View {
    @Binding var selectedAvatar: String
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4"] // Add your avatar image names here

    var body: some View {
        VStack {
            Text("Select Your Avatar")
                .font(.largeTitle)
                .padding()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(avatars, id: \.self) { avatar in
                        Image(avatar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .background(selectedAvatar == avatar ? Color.blue : Color.clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedAvatar = avatar
                            }
                    }
                }
            }
        }
        .padding()
    }
}

struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView(selectedAvatar: .constant("avatar1"))
    }
}