/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 An observable state object that contains profile details.
 */

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class PromptViewModel: ObservableObject {
    
    // MARK: - Prompt Image
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image, UIImage)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
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
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PromptImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
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
    
    let aiService = AIService.shared
    
    @Published var errorMessage = ""
    @Published var cameraImage: UIImage? {
        didSet {
            if let cameraImage {
                imageState = .success(Image(uiImage: cameraImage), cameraImage)
            } else {
                imageState = .empty
            }
        }
    }
    
    @Published var aircraftList = [Aircraft]()
    @Published private(set) var responseState: ResponseState = .empty
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
            if case .empty = self {
                return false
            } else if case .loading = self {
                return false
            }
            return true
        }
    }
    

    func resetState() {
        responseState = .empty
    }

   
    func generatePrompt() async {
        responseState = .loading(Progress())
        aircraftList.removeAll()
        
        guard case .success(_, let uiImage) = imageState,
        let resizedImage = uiImage.resized(to: 3200) else {
            responseState = .failure(PromptError.NoImage)
            return
        }
        let json = await aiService.generateContent(image: resizedImage)
        
        do {
            let jsonData = Data(json.utf8)
            let decoder = JSONDecoder()
            aircraftList = try decoder.decode([Aircraft].self, from: jsonData)
            responseState = .success(aircraftList)
        } catch {
            errorMessage = error.localizedDescription
            responseState = .failure(error)
        }
    }
    
//    func generatePrompt() async {
//        aircraftList = [
//            Aircraft(aircraftType: "Airbus A320 family", airline: "Wizz Air", engineType: "Turbofan", distinctiveFeatures: "The aircraft has a predominantly white fuselage with distinctive magenta/purple accents on the tail, wingtips, and engine nacelles. It features sharklets on its wingtips.", aircraftRole: "Commercial passenger transport", registrationNumber: "Not visible", countryOfOrigin: "European Union", confidenceScore: 90)
//          ]
//        responseState = .success(aircraftList)
//    }
}
