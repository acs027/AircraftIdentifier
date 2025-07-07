//
//  AircraftIdentifierAppIntent.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import AppIntents
import SwiftUI
import UIKit
import UniformTypeIdentifiers

// MARK: - Photo Selection Intent

/// Intent for selecting a photo and identifying aircraft in it
struct SelectPhotoAndIdentifyAircraftIntent: AppIntent {
    
    // MARK: - AppIntent Properties
    
    static var title: LocalizedStringResource = "Identify Aircraft from Photo"
    
    static var description = IntentDescription("Select a photo and identify the aircraft in it.")
    
    @Parameter(title: "Photo", description: "Choose a photo containing an aircraft")
    var photo: IntentFile
    
    static var parameterSummary: some ParameterSummary {
        Summary("Identify aircraft in \(\.$photo)")
    }
    
    // MARK: - AppIntent Methods
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        do {
            // Validate file type
            guard photo.type?.conforms(to: .image) == true else {
                return .result(dialog: "Please select a valid image file.")
            }
            
            // Convert to UIImage
            guard let uiImage = UIImage(data: photo.data) else {
                return .result(dialog: "Couldn't load the selected image. Please try a different photo.")
            }
            
            // Resize for processing
            guard let resizedImage = uiImage.resized(to: 3200) else {
                return .result(dialog: "Failed to process the image. Please try another photo.")
            }
            
            // Generate identification
            let result = try await AIService.shared.generateContent(image: resizedImage)
            let aircraftList = JSONParser.shared.parseAircraft(from: result)
            
            if aircraftList.isEmpty {
                return .result(dialog: "I couldn't identify any aircraft in this photo. Please try another image.")
            }
            
            let dialog = formatIdentificationResult(aircraftList)
            return .result(dialog: IntentDialog(stringLiteral: dialog))
            
        } catch {
            return .result(dialog: "An error occurred while processing the image. Please try again.")
        }
    }
    
    // MARK: - Private Methods
    
    /// Formats the identification result for display
    /// - Parameter aircraftList: List of identified aircraft
    /// - Returns: Formatted string for the dialog
    private func formatIdentificationResult(_ aircraftList: [Aircraft]) -> String {
        if aircraftList.count == 1 {
            let aircraft = aircraftList[0]
            return "I identified this aircraft as a \(aircraft.aircraftType) operated by \(aircraft.airline)."
        } else {
            let types = aircraftList.map { $0.aircraftType }
            return "This aircraft could be: \(types.joined(separator: ", "))."
        }
    }
}

// MARK: - Last Photo Intent

/// Intent for identifying aircraft in the most recent photo
struct IdentifyLastPhotoIntent: AppIntent {
    
    // MARK: - AppIntent Properties
    
    static var title: LocalizedStringResource = "Identify Last Photo"
    
    static var description = IntentDescription("Identify the aircraft in your most recent photo.")
    
    // MARK: - AppIntent Methods
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        do {
            // Check photo library access
            guard await PhotoLibraryService.shared.requestPhotoLibraryAccess() else {
                return .result(dialog: "I need access to your photo library to identify the last photo. Please check your privacy settings.")
            }
            
            // Fetch last photo
            guard let image = await PhotoLibraryService.shared.fetchAndResizeLastPhoto(maxPixel: 3200) else {
                return .result(dialog: "I couldn't find any photos in your library, or couldn't access the most recent one.")
            }
            
            // Generate identification
            let result = try await AIService.shared.generateContent(image: image)
            let aircraftList = JSONParser.shared.parseAircraft(from: result)
            
            if aircraftList.isEmpty {
                return .result(dialog: "I couldn't identify any aircraft in your last photo. The image might not contain an aircraft.")
            }
            
            let dialog = formatIdentificationResult(aircraftList)
            return .result(dialog: IntentDialog(stringLiteral: dialog))
            
        } catch {
            return .result(dialog: "An error occurred while processing the photo. Please try again.")
        }
    }
    
    // MARK: - Private Methods
    
    /// Formats the identification result for display
    /// - Parameter aircraftList: List of identified aircraft
    /// - Returns: Formatted string for the dialog
    private func formatIdentificationResult(_ aircraftList: [Aircraft]) -> String {
        if aircraftList.count == 1 {
            let aircraft = aircraftList[0]
            return "Your last photo shows a \(aircraft.aircraftType) operated by \(aircraft.airline)."
        } else {
            let types = aircraftList.map { $0.aircraftType }
            return "Your last photo might show: \(types.joined(separator: ", "))."
        }
    }
}

// MARK: - Camera Intent

/// Intent for taking a photo and identifying aircraft
struct TakePhotoAndIdentifyIntent: AppIntent {
    
    // MARK: - AppIntent Properties
    
    static var title: LocalizedStringResource = "Take Photo and Identify"
    
    static var description = IntentDescription("Take a photo and identify the aircraft in it.")
    
    static var openAppWhenRun: Bool = true
    
    // MARK: - AppIntent Methods
    
    @MainActor
    func perform() async throws -> some IntentResult & OpensIntent {
        // This will open your app to the camera view
        return .result(opensIntent: OpenCameraIntent())
    }
}

// MARK: - Open Camera Intent

/// Intent for opening the camera interface
struct OpenCameraIntent: AppIntent {
    
    // MARK: - AppIntent Properties
    
    static var title: LocalizedStringResource = "Open Camera"
    
    static var description = IntentDescription("Open the aircraft identification camera.")
    
    static var openAppWhenRun: Bool = true
    
    // MARK: - AppIntent Methods
    
    @MainActor
    func perform() async throws -> some IntentResult {
        UserDefaults.standard.set(true, forKey: "shouldOpenCamera")
        return .result()
    }
}

// MARK: - Intent Configuration

@available(iOS 17.0, *)
extension SelectPhotoAndIdentifyAircraftIntent {
    static var supportedTypes: [UTType] {
        [.image, .jpeg, .png, .heic]
    }
}
