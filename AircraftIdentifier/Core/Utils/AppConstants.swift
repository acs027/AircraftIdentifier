//
//  Constants.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.09.2025.
//

import Foundation
import SwiftUI

struct AppConstants {
    enum AircraftInfo {
        static let type = "Aircraft Type"
        static let role = "Aircraft Role"
        static let airline = "Airline"
        static let engineType = "Engine Type"
        static let distinctiveFeature = "Distinctive Features"
        static let confidence = "Confidence Score"
    }
    
    enum IdentificationResult {
        static let textColor = Color.secondary
        static let errorColor = Color.red
        static let failedText = "Analysis Failed"
        static let aircraftNotFound = "Aircraft not found!"
        static let aircraftNotFoundDescripton = "Try taking a clearer photo or selecting a different image"
    }
    
    enum IdentificationImageState {
        static let emptyStateText = "Select an aircraft image"
        static let stateColor = Color.white
        static let errorStateText = "Failed to load image"
    }
}
