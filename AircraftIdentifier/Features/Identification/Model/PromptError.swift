//
//  PromptError.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 24.06.2025.
//

import Foundation

enum PromptError: Error {
    case NoImage
}

extension PromptError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NoImage:
            "Provide an image."
        }
    }
}
