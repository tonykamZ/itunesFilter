import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchResults: [iTuneFilterApiResponse] = []
    @Published var filteredResults: [iTuneFilterApiResponse] = []
    @Published var searchText: String = "" {
        didSet {
            filterResults()
        }
    }
    @Published var isSearchedEmpty: Bool = false
    @Published var isInitialLoading: Bool = true
    @Published var sortOption: SortOption = .songName {
        didSet {
            sortResults()
        }
    }
    @Published var errorMessage: String?
    
    @Published var currentPage: Int = 1
    let limitPerPage: Int = 20
    
    private var cancellables = Set<AnyCancellable>()
    
    // Requirement 3A: (logic) sorting by Song Name or Album Name
    private var sortedResults: [iTuneFilterApiResponse] {
        switch sortOption {
        case .songName:
            return filteredResults.sorted { $0.trackName < $1.trackName }
        case .albumName:
            return filteredResults.sorted { $0.collectionName < $1.collectionName }
        }
    }

    // Update filteredResults whenever searchText or sortOption changes
    private var searchTextNormalized: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    var totalPages: Int {
        let count = filteredResults.count
        return count > 0 ? (count + limitPerPage - 1) / limitPerPage : 1
    }
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { _ in
                self.filterResults()
            }
            .store(in: &cancellables)
    }
    
    func resetPagination() {
        currentPage = 1
    }

    func performInitialLoad() {
        self.isInitialLoading = true
        self.searchText = "Taylor Swift"
        self.performSearch {
            self.searchText = ""
            self.isInitialLoading = false
        }
    }

    func performSearch(completion: (() -> Void)? = nil) {
        let searchTerm = searchText.replacingOccurrences(of: " ", with: "+")
        // Requirement 1A: Using provided API endpoint
        let apiUrl = "https://itunes.apple.com/search?term=\(searchTerm)&limit=200&media=music"
        errorMessage = nil
        
        guard let url = URL(string: apiUrl) else {
            errorMessage = "Invalid request URL"
            completion?()
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as NSError?, error.code == NSURLErrorTimedOut {
                DispatchQueue.main.async {
                    // Requirement 4B: handle network error state
                    self.errorMessage = "Network time out. Please try again."
                    completion?()
                }
                return
            } else if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    completion?()
                }
                return
            }
                          
            guard let data = data else {
                // Requirement 4B: result empty state (requested data empty)
                self.errorMessage = "No data received"
                completion?()
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    let searchResults = results.compactMap { resultDict -> iTuneFilterApiResponse? in
                        guard let trackName = resultDict["trackName"] as? String,
                              let artistName = resultDict["artistName"] as? String,
                              let primaryGenreName = resultDict["primaryGenreName"] as? String,
                              let collectionName = resultDict["collectionName"] as? String,
                              let collectionId = resultDict["collectionId"] as? Int,
                              let artworkUrl100 = resultDict["artworkUrl100"] as? String,
                              let previewUrl = resultDict["previewUrl"] as? String else {
                            return nil
                        }
                        return iTuneFilterApiResponse(trackName: trackName, artistName: artistName, primaryGenreName: primaryGenreName, collectionName: collectionName, collectionId: collectionId, artworkUrl100: artworkUrl100, previewUrl: previewUrl)
                    }
                    
                    DispatchQueue.main.async {
                        self.searchResults = searchResults
                        self.filteredResults = searchResults
                        self.sortResults()
                        self.isSearchedEmpty = searchResults.isEmpty
                        completion?()
                    }
                } else {
                    self.errorMessage = "Failed to decode JSON data: Invalid format."
                    completion?()
                }
            } catch {
                self.errorMessage = "Error decoding JSON data: \(error)"
                completion?()
            }
        }.resume()
    }

    func filterResults() {
        if searchText.isEmpty {
            filteredResults = searchResults
        } else {
            // Requirement 2B: Search by Song Name and Album Name
            filteredResults = searchResults.filter { result in
                result.trackName.lowercased().contains(searchText.lowercased()) || result.collectionName.lowercased().contains(searchText.lowercased())
            }
        }
        sortResults()
        currentPage = 1
        self.isSearchedEmpty = filteredResults.isEmpty
    }

    func sortResults() {
        switch sortOption {
        // Requirement 3B: Sorting the list by ascending order
        case .songName:
            filteredResults.sort { $0.trackName.lowercased() < $1.trackName.lowercased() }
        case .albumName:
            filteredResults.sort { $0.collectionName.lowercased() < $1.collectionName.lowercased() }
        }
    }
}
