//
//  AIService.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 13.06.2025.
//

import Foundation
import FirebaseAI
import UIKit
import SwiftUI
import Photos

class AIService {
    
    static let shared = AIService()
    let model: GenerativeModel
    let ai: FirebaseAI
    
    private init() {
        // Define the structured JSON schema
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
        
        // Schema for an array of aircrafts
        let jsonSchema = Schema.array(items: aircraftSchema)
        
        
        // Initialize the Gemini Developer API backend service
        self.ai = FirebaseAI.firebaseAI(backend: .googleAI())
        
        // Create a GenerativeModel instance with JSON response config
        self.model = ai.generativeModel(
            modelName: "gemini-2.5-flash",
            generationConfig: GenerationConfig(
                responseMIMEType: "application/json",
                responseSchema: jsonSchema
            )
        )
    }
    
    func generateContent(image: UIImage) async -> String {
        do {
            print(image.size.width, image.size.height)
            let prompt =
            """
            You are an aviation expert.
            
            Analyze the image and identify all visible aircraft.
            
            For each aircraft, return an object with these fields:
            - aircraftType (string)
            - airline (string)
            - engineType (string)
            - distinctiveFeatures (string, up to 2 short sentences)
            - aircraftRole (string)
            - registrationNumber (string)
            - countryOfOrigin (string)
            - confidenceScore (integer between 0 and 100)
            
            If any field cannot be determined, use 'Unknown' or 'Not visible'.
            
            Return the result as a JSON array of aircraft objects.
            """
            
            let response = try await model.generateContent(image, prompt)
            
            if let json = response.text {
                print(json)
                return json
            } else {
                return "⚠️ No text in response."
            }
            //
        } catch {
            return "❌ Error generating content: \(error.localizedDescription)"
        }
    }
}
