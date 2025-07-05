
import SwiftUI
import PhotosUI

struct IdentificationView: View {
    @StateObject var viewModel = PromptViewModel()
    @EnvironmentObject var appState: AppState
    @State private var cameraError: CameraPermission.CameraError?
    @State private var isResponseShowing = false
    
    var body: some View {
        VStack {
            ZStack {
                if !isResponseShowing {
                    EditablePromptImage(viewModel: viewModel)
                        .overlay(alignment: .bottomLeading) {
                            cameraButton
                        }
                        .transition(.circularReveal)
                } else {
                    IdentificationResultView(vm: viewModel)
                        .transition(.circularReveal)
                }
            }
            .animation(.easeInOut(duration: 0.6), value: isResponseShowing)
            Spacer()
            actionButton
 
        }
        .padding()
        .onChange(of: viewModel.responseState.isProcessDone) { oldValue, newValue in
            if newValue {
                isResponseShowing = true
            }
        }
        .navigationTitle("Aircraft Identifier")
    }
    
    private var cameraButton: some View {
        Button {
            if let error = CameraPermission.checkPermissions() {
                cameraError = error
            } else {
                appState.shouldOpenCamera.toggle()
            }
        } label: {
            Image(systemName: "camera.circle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 50))
                .foregroundColor(.accentColor)
                .padding()
                .buttonStyle(.borderless)
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
    
    private var actionButton: some View {
        Button {
            handleButton()
        } label: {
            ButtonLabel(imageSystemName: isResponseShowing ? "arrow.trianglehead.counterclockwise" : "magnifyingglass")
        }
    }
    
    private func handleButton() {
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



