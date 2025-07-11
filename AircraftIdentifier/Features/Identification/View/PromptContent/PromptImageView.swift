import SwiftUI
import PhotosUI

/// View for displaying prompt images with different states
struct PromptImageView: View {
    
    // MARK: - Properties
    
    let imageState: PromptViewModel.ImageState
    
    // MARK: - Body
    
    var body: some View {
        switch imageState {
        case .success(let image, _):
            image
                .resizable()
                .accessibilityLabel("Selected aircraft image")
            
        case .loading:
            ProgressView()
                .accessibilityLabel("Loading image")
            
        case .empty:
            emptyStateView
            
        case .failure:
            errorStateView
        }
    }
    
    // MARK: - Private Views
    
    /// View displayed when no image is selected
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "airplane")
                .font(.system(size: 40))
                .foregroundColor(.white)
            
            Text("Select an aircraft image")
                .font(.body)
                .foregroundColor(.white)
        }
        .accessibilityLabel("No image selected")
        .accessibilityHint("Tap to select an aircraft photo")
    }
    
    /// View displayed when image loading fails
    private var errorStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
            
            Text("Failed to load image")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .accessibilityLabel("Image loading failed")
    }
}

/// Container view for prompt images with gradient background
struct PromptImageContainer: View {
    
    // MARK: - Properties
    
    let imageState: PromptViewModel.ImageState
    
    // MARK: - Body
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
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
            .accessibilityElement(children: .contain)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        PromptImageContainer(imageState: .empty)
        PromptImageContainer(imageState: .loading(Progress()))
        PromptImageContainer(imageState: .failure(NSError(domain: "test", code: 1)))
    }
    .padding()
}

