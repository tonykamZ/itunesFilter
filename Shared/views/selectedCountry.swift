import SwiftUI

struct SelectedCountryView: View {
    var selectedCountry: String

    var body: some View {
        Text("Current country: \(selectedCountry)")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding()
    }
}
