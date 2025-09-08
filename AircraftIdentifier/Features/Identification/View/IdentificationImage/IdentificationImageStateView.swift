import SwiftUI
import PhotosUI

/// View for displaying prompt images with different states
struct IdentificationImageStateView: View {
    
    // MARK: - Properties
    
    let imageState: IdentificationViewModel.ImageState
    
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
            Text(AppConstants.IdentificationImageState.emptyStateText)
                .modifier(TitleModifier())
        }
        .foregroundColor(AppConstants.IdentificationImageState.stateColor)
        .accessibilityLabel("No image selected")
        .accessibilityHint("Tap to select an aircraft photo")
    }
    
    /// View displayed when image loading fails
    private var errorStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
            
            Text(AppConstants.IdentificationImageState.errorStateText)
                .modifier(TitleModifier())
        }
        .foregroundColor(AppConstants.IdentificationImageState.stateColor)
        .accessibilityLabel("Image loading failed")
    }
}



// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        IdentificationImageContainer(imageState: .empty)
        IdentificationImageContainer(imageState: .loading(Progress()))
        IdentificationImageContainer(imageState: .failure(NSError(domain: "test", code: 1)))
    }
    .padding()
}

