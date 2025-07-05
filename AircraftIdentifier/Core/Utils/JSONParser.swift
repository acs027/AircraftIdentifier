//
//  JSONParser.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 3.07.2025.
//

import Foundation

class JSONParser {
    static let shared = JSONParser()
    
    private init() {}
    
    /// Parses JSON string into an array of Aircraft objects
    /// - Parameter jsonString: JSON string to parse
    /// - Returns: Array of Aircraft objects, empty array if parsing fails
    func parseAircraft(from jsonString: String) -> [Aircraft] {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("⚠️ Failed to convert string to data")
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let aircraftList = try decoder.decode([Aircraft].self, from: jsonData)
            return aircraftList
        } catch {
            print("⚠️ JSON parsing error: \(error.localizedDescription)")
            return []
        }
    }
}
