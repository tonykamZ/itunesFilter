import SwiftUI

struct SearchResult: View {
    let result: iTuneFilterApiResponse

    var body: some View {
        HStack {
            if let url = URL(string: result.artworkUrl100) {
                RemoteImageView(url: url)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(result.trackName)
                    .font(.headline)
                Text(result.collectionName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(result.artistName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .id(result.id) 
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct RemoteImageView: View {
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading = true

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        task.resume()
    }
}
