import SwiftUI
import PhotosUI

/// Main view for aircraft identification functionality
struct IdentificationView: View {
    
    // MARK: - State Objects
    
    @StateObject private var viewModel = IdentificationViewModel()
    @EnvironmentObject private var appState: AppState
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                mainCardView
                Spacer()
                actionButton
            }
            .padding()
            .alert(isPresented: .constant(viewModel.checkCameraError()), error: viewModel.cameraError) { _ in
                Button("OK") {
                    handleCameraPermissionAlert()
                }
            } message: { error in
                Text(error.recoverySuggestion ?? "Try again later")
            }
            
            .fullScreenCover(isPresented: $appState.shouldOpenCamera) {
                UIKitCamera(selectedImage: $viewModel.cameraImage)
                    .ignoresSafeArea()
            }
            .navigationTitle("Aircraft Identifier")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Private Views
    
    private var mainCardView: some View {
        ZStack {
            if !viewModel.responseState.isProcessDone {
                IdentificationImageView(viewModel: viewModel)
                    .overlay(alignment: .bottomLeading) {
                        cameraButton
                    }
                    .transition(.circularReveal)
                    .accessibilityLabel("Image selection area")
            } else {
                IdentificationResultView(viewModel: viewModel)
                    .transition(.circularReveal)
                    .accessibilityLabel("Aircraft identification results")
            }
        }
        .animation(.easeInOut(duration: 0.6), value: viewModel.responseState.isProcessDone)
    }
    
    /// Camera button for capturing photos
    private var cameraButton: some View {
        Button {
            handleCameraButtonTap()
        } label: {
            Image(systemName: "camera.circle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 50))
                .foregroundColor(.accentColor)
                .padding()
                .buttonStyle(.borderless)
        }
        .accessibilityLabel("Take photo")
        .accessibilityHint("Opens camera to capture aircraft photo")
    }
    
    /// Main action button for identification or reset
    private var actionButton: some View {
        Button {
            handleActionButtonTap()
        } label: {
            ButtonLabel(imageSystemName: viewModel.responseState.isProcessDone ? "arrow.trianglehead.counterclockwise" : "magnifyingglass")
        }
        .accessibilityLabel(viewModel.responseState.isProcessDone ? "Reset identification" : "Identify aircraft")
        .accessibilityHint(viewModel.responseState.isProcessDone ? "Start over with a new image" : "Analyze the current image")
    }
    
    // MARK: - Private Methods
    
    /// Handles camera button tap with permission checking
    private func handleCameraButtonTap() {
        viewModel.handleCameraButtonAction(appState: appState)
    }
    
    /// Handles main action button tap
    private func handleActionButtonTap() {
        viewModel.handleActionButtonTap()
    }
    
    private func handleCameraPermissionAlert() {
        viewModel.clearCameraError()
    }
}

// MARK: - Preview

#Preview {
    @Previewable @StateObject var appState = AppState()
    
    return IdentificationView()
        .environmentObject(appState)
}



