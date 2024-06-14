import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading...")
                .font(.headline)
                .padding(.top, 8)
        }
        .padding()
    }
}
