import SwiftUI
import PhotosUI

/// Main view for aircraft identification functionality
struct IdentificationView: View {
    
    // MARK: - State Objects
    
    @StateObject private var viewModel = PromptViewModel()
    @EnvironmentObject private var appState: AppState
    
    // MARK: - State Properties
    
    @State private var cameraError: CameraPermission.CameraError?
    @State private var isResponseShowing = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                if !isResponseShowing {
                    EditablePromptImage(viewModel: viewModel)
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
            .animation(.easeInOut(duration: 0.6), value: isResponseShowing)
            
            Spacer()
            
            actionButton
        }
        .padding()
        .onChange(of: viewModel.responseState.isProcessDone) { _, newValue in
            if newValue {
                isResponseShowing = true
            }
        }
        .alert(isPresented: .constant(cameraError != nil), error: cameraError) { _ in
            Button("OK") {
                cameraError = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "Try again later")
        }
        .fullScreenCover(isPresented: $appState.shouldOpenCamera) {
            UIKitCamera(selectedImage: $viewModel.cameraImage)
                .ignoresSafeArea()
        }
    }
    
    // MARK: - Private Views
    
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
            ButtonLabel(imageSystemName: isResponseShowing ? "arrow.trianglehead.counterclockwise" : "magnifyingglass")
        }
        .accessibilityLabel(isResponseShowing ? "Reset identification" : "Identify aircraft")
        .accessibilityHint(isResponseShowing ? "Start over with a new image" : "Analyze the current image")
    }
    
    // MARK: - Private Methods
    
    /// Handles camera button tap with permission checking
    private func handleCameraButtonTap() {
        if let error = CameraPermission.checkPermissions() {
            cameraError = error
        } else {
            appState.openCamera()
        }
    }
    
    /// Handles main action button tap
    private func handleActionButtonTap() {
        if isResponseShowing {
            viewModel.resetState()
            isResponseShowing.toggle()
        } else {
            Task {
                await viewModel.generatePrompt()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @StateObject var appState = AppState()
    
    return IdentificationView()
        .environmentObject(appState)
}



