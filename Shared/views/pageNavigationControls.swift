import SwiftUI

struct PageNavigationControls: View {
    @Binding var currentPage: Int
    var totalPages: Int

    var body: some View {
        HStack {
            Button(action: {
                if currentPage > 1 {
                    currentPage -= 1
                }
            }) {
                Image(systemName: "chevron.left")
            }
            .disabled(currentPage <= 1)
            
            Text("Page \(currentPage) of \(totalPages)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            
            Button(action: {
                if currentPage < totalPages {
                    currentPage += 1
                }
            }) {
                Image(systemName: "chevron.right")
            }
            .disabled(currentPage >= totalPages)
        }
        .padding()
    }
}
