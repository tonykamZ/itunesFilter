import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var currentPage: Int

    var displayedResults: [iTuneFilterApiResponse] {
        let startIndex = (currentPage - 1) * 20
        let endIndex = min(startIndex + 20, viewModel.filteredResults.count)
        guard startIndex < endIndex else {
            return []
        }
                   
        return Array(viewModel.filteredResults[startIndex..<endIndex])

    }

    var body: some View {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ForEach(displayedResults) { result in
                            SearchResult(result: result)
                                .padding(.bottom, 8)
                        }
                    }
                    .padding()
                    .onChange(of: currentPage) { _ in
                        withAnimation {
                            proxy.scrollTo(0, anchor: .top)
                        }
                    }
                }
            }
        }
}
