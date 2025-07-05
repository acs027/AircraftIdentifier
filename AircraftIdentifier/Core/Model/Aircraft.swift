//
//  Aircraft.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 20.06.2025.
//

import Foundation

struct Aircraft: Identifiable, Codable {
    let id: UUID = UUID()  // Unique ID for SwiftUI or tracking

    let aircraftType: String
    let airline: String
    let engineType: String
    let distinctiveFeatures: String
    let aircraftRole: String
    let registrationNumber: String
    let countryOfOrigin: String
    let confidenceScore: Int

    private enum CodingKeys: String, CodingKey {
        case aircraftType, airline, engineType, distinctiveFeatures,
             aircraftRole, registrationNumber, countryOfOrigin, confidenceScore
    }
}

