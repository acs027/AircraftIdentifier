//
//  JSONParser.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 3.07.2025.
//

import Foundation

/// Service for parsing JSON data into Aircraft objects
final class JSONParser {
    
    // MARK: - Singleton
    
    static let shared = JSONParser()
    
    // MARK: - Error Types
    
    enum JSONParserError: LocalizedError {
        case invalidData
        case decodingFailed(Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidData:
                return "Invalid JSON data"
            case .decodingFailed(let error):
                return "Failed to decode JSON: \(error.localizedDescription)"
            }
        }
    }
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Parses JSON string into an array of Aircraft objects
    /// - Parameter jsonString: JSON string to parse
    /// - Returns: Array of Aircraft objects, empty array if parsing fails
    func parseAircraft(from jsonString: String) -> [Aircraft] {
        do {
            let aircraftList = try parseAircraftThrowing(from: jsonString)
            return aircraftList
        } catch {
            print("⚠️ JSON parsing error: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Parses JSON string into an array of Aircraft objects with error throwing
    /// - Parameter jsonString: JSON string to parse
    /// - Returns: Array of Aircraft objects
    /// - Throws: JSONParserError if parsing fails
    func parseAircraftThrowing(from jsonString: String) throws -> [Aircraft] {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw JSONParserError.invalidData
        }
        
        do {
            let decoder = JSONDecoder()
            let aircraftList = try decoder.decode([Aircraft].self, from: jsonData)
            return aircraftList
        } catch {
            throw JSONParserError.decodingFailed(error)
        }
    }
    
    /// Parses JSON data into an array of Aircraft objects
    /// - Parameter data: JSON data to parse
    /// - Returns: Array of Aircraft objects, empty array if parsing fails
    func parseAircraft(from data: Data) -> [Aircraft] {
        do {
            let decoder = JSONDecoder()
            let aircraftList = try decoder.decode([Aircraft].self, from: data)
            return aircraftList
        } catch {
            print("⚠️ JSON parsing error: \(error.localizedDescription)")
            return []
        }
    }
}
