//
//  Aircraft.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 20.06.2025.
//

import Foundation

/// Represents an aircraft with identification details
struct Aircraft: Identifiable, Codable, Hashable {
    /// Unique identifier for the aircraft
    let id = UUID()
    
    /// Type of the aircraft (e.g., "Airbus A320", "Boeing 737")
    let aircraftType: String
    
    /// Operating airline or carrier
    let airline: String
    
    /// Type of engines used (e.g., "Turbofan", "Turboprop")
    let engineType: String
    
    /// Distinctive visual features of the aircraft
    let distinctiveFeatures: String
    
    /// Primary role of the aircraft (e.g., "Commercial passenger transport")
    let aircraftRole: String
    
    /// Aircraft registration number
    let registrationNumber: String
    
    /// Country where the aircraft is registered
    let countryOfOrigin: String
    
    /// Confidence score for the identification (0-100)
    let confidenceScore: Int
    
    // MARK: - Codable Implementation
    
    private enum CodingKeys: String, CodingKey {
        case aircraftType, airline, engineType, distinctiveFeatures,
             aircraftRole, registrationNumber, countryOfOrigin, confidenceScore
    }
    
    // MARK: - Initializer
    
    init(aircraftType: String, airline: String, engineType: String, 
         distinctiveFeatures: String, aircraftRole: String, 
         registrationNumber: String, countryOfOrigin: String, confidenceScore: Int) {
        self.aircraftType = aircraftType
        self.airline = airline
        self.engineType = engineType
        self.distinctiveFeatures = distinctiveFeatures
        self.aircraftRole = aircraftRole
        self.registrationNumber = registrationNumber
        self.countryOfOrigin = countryOfOrigin
        self.confidenceScore = max(0, min(100, confidenceScore)) // Ensure score is between 0-100
    }
}

