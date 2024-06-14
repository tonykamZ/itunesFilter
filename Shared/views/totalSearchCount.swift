import SwiftUI

struct TotalSearchCountView: View {
    @ObservedObject var viewModel: HomeViewModel

    var totalCount: Int {
        viewModel.filteredResults.count
    }

    var body: some View {
        Text("Total results: \(totalCount)")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding()
            .onChange(of: viewModel.filteredResults) { _ in
                // Update totalCount when filteredResults change
                // This ensures the count is updated dynamically
            }
    }
}
