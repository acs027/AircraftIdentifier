
import SwiftUI
import PhotosUI

struct PromptImageView: View {
    let imageState: PromptViewModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image, _):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "airplane")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct PromptImageContainer: View {
    let imageState: PromptViewModel.ImageState
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25).fill(
            LinearGradient(
                colors: [.yellow, .orange],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay {
            PromptImageView(imageState: imageState)
                .scaledToFill()
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

