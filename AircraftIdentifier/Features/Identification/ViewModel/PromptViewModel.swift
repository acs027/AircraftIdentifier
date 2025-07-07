/*
 See the LICENSE.txt file for this sample's licensing information.
 
 Abstract:
 An observable state object that contains profile details.
 */

import SwiftUI
import PhotosUI
import CoreTransferable

/// ViewModel for managing aircraft identification prompts and results
@MainActor
final class PromptViewModel: ObservableObject {
    
    // MARK: - Image State
    
    /// Represents the current state of the prompt image
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image, UIImage)
        case failure(Error)
        
        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }
        
        var hasImage: Bool {
            if case .success = self { return true }
            return false
        }
    }
    
    /// Represents the current state of the AI response
    enum ResponseState {
        case empty
        case loading(Progress)
        case success([Aircraft])
        case failure(Error)
        
        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }
        
        var isProcessDone: Bool {
            switch self {
            case .empty, .loading:
                return false
            case .success, .failure:
                return true
            }
        }
    }
    
    // MARK: - Transferable Types
    
    enum TransferError: LocalizedError {
        case importFailed
        
        var errorDescription: String? {
            "Failed to import image"
        }
    }
    
    struct PromptImage: Transferable {
        let image: Image
        let uiImage: UIImage
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return PromptImage(image: image, uiImage: uiImage)
            }
        }
    }
    
    // MARK: - Published Properties
    
    @Published private(set) var imageState: ImageState = .empty
    @Published private(set) var responseState: ResponseState = .empty
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            handleImageSelection()
        }
    }
    @Published var cameraImage: UIImage? {
        didSet {
            handleCameraImage()
        }
    }
    @Published var aircraftList: [Aircraft] = []
    @Published var errorMessage: String = ""
    
    // MARK: - Private Properties
    
    private let aiService = AIService.shared
    
    // MARK: - Public Methods
    
    /// Resets the view model state
    func resetState() {
        responseState = .empty
        aircraftList.removeAll()
        errorMessage = ""
    }
    
    /// Generates aircraft identification from the current image
    func generatePrompt() async {
        responseState = .loading(Progress())
        aircraftList.removeAll()
        
        guard case .success(_, let uiImage) = imageState,
              let resizedImage = uiImage.resized(to: 3200) else {
            responseState = .failure(PromptError.noImage)
            return
        }
        
        do {
            let json = try await aiService.generateContent(image: resizedImage)
            let jsonData = Data(json.utf8)
            let decoder = JSONDecoder()
            aircraftList = try decoder.decode([Aircraft].self, from: jsonData)
            responseState = .success(aircraftList)
        } catch {
            errorMessage = error.localizedDescription
            responseState = .failure(error)
        }
    }
    
    // MARK: - Private Methods
    
    /// Handles image selection from photo picker
    private func handleImageSelection() {
        if let imageSelection {
            let progress = loadTransferable(from: imageSelection)
            imageState = .loading(progress)
        } else {
            imageState = .empty
        }
    }
    
    /// Handles camera image capture
    private func handleCameraImage() {
        if let cameraImage {
            imageState = .success(Image(uiImage: cameraImage), cameraImage)
        } else {
            imageState = .empty
        }
    }
    
    /// Loads transferable image from PhotosPickerItem
    /// - Parameter imageSelection: The selected photo picker item
    /// - Returns: Progress object for tracking the transfer
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PromptImage.self) { [weak self] result in
            Task { @MainActor in
                guard let self = self,
                      imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                
                switch result {
                case .success(let promptImage?):
                    self.imageState = .success(promptImage.image, promptImage.uiImage)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
