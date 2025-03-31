import SwiftUI

struct ThemeSelectionView: View {
    @Binding var selectedTheme: String
    let themes = ["Ocean Blue", "Sunset Orange", "Forest Green", "Blood Orange", "Blood Red", "Hazy Gray", "Nike Gray And Black (Including Fonts As Well)"] // Add your theme names here

    var body: some View {
        VStack {
            Text("Select Your Theme")
                .font(.largeTitle)
                .padding()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(themes, id: \.self) { theme in
                        Text(theme)
                            .font(.headline)
                            .padding()
                            .background(selectedTheme == theme ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTheme = theme
                            }
                    }
                }
            }
        }
        .padding()
    }
}

struct ThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelectionView(selectedTheme: .constant("Light"))
    }
}