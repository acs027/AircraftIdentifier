//
//  PromptError.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 24.06.2025.
//

import Foundation

/// Errors that can occur during prompt processing
enum PromptError: LocalizedError {
    case noImage
    case invalidImage
    case processingFailed
    
    var errorDescription: String? {
        switch self {
        case .noImage:
            return "Please provide an image to analyze"
        case .invalidImage:
            return "The provided image is invalid or corrupted"
        case .processingFailed:
            return "Failed to process the image"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .noImage:
            return "Select an image from your photo library or take a new photo"
        case .invalidImage:
            return "Try selecting a different image"
        case .processingFailed:
            return "Please try again with a clearer image"
        }
    }
}
