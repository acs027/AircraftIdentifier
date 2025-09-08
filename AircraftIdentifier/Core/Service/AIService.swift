//
//  AIService.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 13.06.2025.
//

import Foundation
import FirebaseAI
import UIKit

/// Service for AI-powered aircraft identification
@MainActor
final class AIService {
    
    // MARK: - Singleton
    
    static let shared = AIService()
    
    // MARK: - Private Properties
    
    private let model: GenerativeModel
    private let ai: FirebaseAI
    
    // MARK: - Error Types
    
    enum AIServiceError: LocalizedError {
        case invalidResponse
        case networkError(Error)
        case imageProcessingError
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from AI service"
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
            case .imageProcessingError:
                return "Failed to process image"
            }
        }
    }
    
    // MARK: - Initializer
    
    private init() {
        // Define the structured JSON schema for aircraft data
        let aircraftSchema = Schema.object(
            properties: [
                "aircraftType": .string(),
                "airline": .string(),
                "engineType": .string(),
                "distinctiveFeatures": .string(),
                "aircraftRole": .string(),
                "registrationNumber": .string(),
                "countryOfOrigin": .string(),
                "confidenceScore": .integer()
            ]
        )
        
        // Schema for an array of aircraft
        let jsonSchema = Schema.array(items: aircraftSchema)
        
        // Initialize Firebase AI with Google AI backend
        self.ai = FirebaseAI.firebaseAI(backend: .googleAI())
        
        // Create GenerativeModel with JSON response configuration
        self.model = ai.generativeModel(
            modelName: "gemini-2.5-flash",
            generationConfig: GenerationConfig(
                responseMIMEType: "application/json",
                responseSchema: jsonSchema
            )
        )
    }
    
    // MARK: - Public Methods
    
    /// Generates aircraft identification content from an image
    /// - Parameter image: The image to analyze
    /// - Returns: JSON string containing aircraft data
    /// - Throws: AIServiceError if the operation fails
    func generateContent(image: UIImage) async throws -> String {
        do {
            debugPrint("Processing image: \(image.size.width) x \(image.size.height)")
            
            let prompt = createAnalysisPrompt()
            let response = try await model.generateContent(image, prompt)
            
            guard let json = response.text, !json.isEmpty else {
                throw AIServiceError.invalidResponse
            }
            
            debugPrint("AI Response: \(json)")
            return json
            
        } catch let error as AIServiceError {
            throw error
        } catch {
            throw AIServiceError.networkError(error)
        }
    }
    
    // MARK: - Private Methods
    
    /// Creates the analysis prompt for aircraft identification
    /// - Returns: The formatted prompt string
    private func createAnalysisPrompt() -> String {
        """
        You are an aviation expert.
        
        Analyze the image and identify all visible aircraft.
        
        For each aircraft, return an object with these fields:
        - aircraftType (string): Specific aircraft model and family
        - airline (string): Operating airline or carrier name
        - engineType (string): Engine configuration (e.g., "Turbofan", "Turboprop")
        - distinctiveFeatures (string): Key visual characteristics (max 2 sentences)
        - aircraftRole (string): Primary purpose (e.g., "Commercial passenger transport")
        - registrationNumber (string): Aircraft registration if visible
        - countryOfOrigin (string): Country of registration or manufacturer
        - confidenceScore (integer): Confidence level 0-100
        
        If any field cannot be determined, use 'Unknown' or 'Not visible'.
        
        Return the result as a JSON array of aircraft objects.
        """
    }
}
