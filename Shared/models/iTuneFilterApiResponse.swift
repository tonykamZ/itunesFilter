import Foundation

struct iTuneFilterApiResponse: Identifiable, Codable, Equatable {
    var id = UUID()
    let artistName: String
    let trackName: String
    let primaryGenreName: String
    let collectionName: String
    let collectionId: Int
    let artworkUrl100: String
    let previewUrl: String

    init(trackName: String, artistName: String, primaryGenreName: String, collectionName: String, collectionId: Int, artworkUrl100: String, previewUrl: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.primaryGenreName = primaryGenreName
        self.collectionName = collectionName
        self.collectionId = collectionId
        self.artworkUrl100 = artworkUrl100
        self.previewUrl = previewUrl
    }

    static func == (lhs: iTuneFilterApiResponse, rhs: iTuneFilterApiResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
