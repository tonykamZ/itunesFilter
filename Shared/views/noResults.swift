import SwiftUI

struct NoResultsView: View {
    let searchText: String

    var body: some View {
        VStack {
            Text("No results match with '\(searchText)'")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
    }
}
