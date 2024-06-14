import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        TextField("Search by song or album name", text: $viewModel.searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
    }
}
