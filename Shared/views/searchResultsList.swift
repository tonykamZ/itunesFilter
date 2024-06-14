import SwiftUI

struct SearchResultsList: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var currentPage: Int
    
    private let resultsPerPage = 20

    var displayedResults: [iTuneFilterApiResponse] {
        let totalCount = viewModel.searchResults.count
        let startIndex = (currentPage - 1) * resultsPerPage
        let endIndex = min(startIndex + resultsPerPage, totalCount)
        
        guard startIndex < totalCount, startIndex >= 0, endIndex > startIndex else {
            return []
        }
        
        return Array(viewModel.searchResults[startIndex..<endIndex])
    }

    var body: some View {
        VStack {
            ForEach(displayedResults) { result in
                // Requirement 4A: a list of filtered and sorted result
                SearchResult(result: result)
                    .padding(.bottom, 8)
            }
        }
        .padding()
    }
}
