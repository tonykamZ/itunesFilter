import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isInitialLoading {
                    VStack {
                        Text("iTunes Filter")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        Text("Start by filtering the music by keywords.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                        ProgressView()
                            .scaleEffect(1.5)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding()
                        Button(action: {
                            viewModel.performInitialLoad()
                        }) {
                            Text("Retry")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                } else {
                    SearchBarView(viewModel: viewModel)
                    EntitySelectionRow(viewModel: viewModel)
                    
                    if viewModel.isSearchedEmpty {
                        NoResultsView(searchText: viewModel.searchText)
                        Spacer()
                    } else {
                        if !viewModel.filteredResults.isEmpty {
                            TotalSearchCountView(viewModel: viewModel)
                        }
                        SearchResultsView(viewModel: viewModel, currentPage: $viewModel.currentPage)
                        if !viewModel.filteredResults.isEmpty {
                            PageNavigationControls(currentPage: $viewModel.currentPage, totalPages: viewModel.totalPages)
                        }
                    }
                }
            }
            .navigationBarTitle(viewModel.isInitialLoading ? "" : "iTunes Filter")
            .onAppear {
                viewModel.performInitialLoad()
            }
        }
        .onChange(of: viewModel.searchText) { _ in
            viewModel.filterResults()
        }
    }
}
