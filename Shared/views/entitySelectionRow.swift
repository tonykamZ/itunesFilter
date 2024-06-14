import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case songName = "Song Name"
    case albumName = "Album Name"
    
    var id: String { self.rawValue }
}

struct EntitySelectionRow: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HStack {
            // Requirement 3A: (UI) sorting buttons by Song Name or Album Name
            ForEach(SortOption.allCases) { option in
                Button(action: {
                    viewModel.sortOption = option
                }) {
                    Text(option.rawValue)
                        .padding(8)
                        .background(viewModel.sortOption == option ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
