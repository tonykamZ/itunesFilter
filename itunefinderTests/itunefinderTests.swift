import XCTest
@testable import itune_finder

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialLoad() {
        let expectation = self.expectation(description: "Initial load")
        
        viewModel.performInitialLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertFalse(self.viewModel.isInitialLoading, "Initial loading should be false")
            XCTAssertTrue(self.viewModel.searchResults.isEmpty == false, "Search results should not be empty")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformSearchWithInvalidURL() {
        viewModel.searchText = "" // Set to an invalid search term to trigger invalid URL

        let expectation = self.expectation(description: "Invalid URL")

        viewModel.performSearch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertEqual(self.viewModel.errorMessage, "Invalid request URL", "Error message should be 'Invalid request URL'")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformSearchWithValidResponse() {
        let expectation = self.expectation(description: "Search with valid response")
        
        viewModel.searchText = "Taylor Swift"
        viewModel.performSearch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertTrue(self.viewModel.searchResults.count > 0, "Search results should not be empty")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFilterResults() {
        viewModel.searchResults = [
            iTuneFilterApiResponse(trackName: "Track1", artistName: "Artist1", primaryGenreName: "Genre1", collectionName: "Album1", collectionId: 1, artworkUrl100: "", previewUrl: ""),
            iTuneFilterApiResponse(trackName: "Track2", artistName: "Artist2", primaryGenreName: "Genre2", collectionName: "Album2", collectionId: 2, artworkUrl100: "", previewUrl: "")
        ]
        
        viewModel.searchText = "Track1"
        viewModel.filterResults()
        
        XCTAssertEqual(viewModel.filteredResults.count, 1, "Filtered results should contain one item")
        XCTAssertEqual(viewModel.filteredResults.first?.trackName, "Track1", "Filtered result should be 'Track1'")
    }
    
    func testSortResultsBySongName() {
        viewModel.filteredResults = [
            iTuneFilterApiResponse(trackName: "B", artistName: "Artist1", primaryGenreName: "Genre1", collectionName: "Album1", collectionId: 1, artworkUrl100: "", previewUrl: ""),
            iTuneFilterApiResponse(trackName: "A", artistName: "Artist2", primaryGenreName: "Genre2", collectionName: "Album2", collectionId: 2, artworkUrl100: "", previewUrl: "")
        ]
        
        viewModel.sortOption = .songName
        viewModel.sortResults()
        
        XCTAssertEqual(viewModel.filteredResults.first?.trackName, "A", "First item should be 'A' after sorting by song name")
    }
    
    func testSortResultsByAlbumName() {
           viewModel.filteredResults = [
               iTuneFilterApiResponse(trackName: "Track1", artistName: "Artist1", primaryGenreName: "Genre1", collectionName: "B", collectionId: 1, artworkUrl100: "", previewUrl: ""),
               iTuneFilterApiResponse(trackName: "Track2", artistName: "Artist2", primaryGenreName: "Genre2", collectionName: "A", collectionId: 2, artworkUrl100: "", previewUrl: "")
           ]
           
           viewModel.sortOption = .albumName
           viewModel.sortResults()
           
           XCTAssertEqual(viewModel.filteredResults.first?.collectionName, "A", "First item should be 'A' after sorting by album name")
       }
   }
