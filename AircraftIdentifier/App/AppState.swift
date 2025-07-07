//
//  AppState.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 4.07.2025.
//

import SwiftUI

/// Global application state manager
@MainActor
final class AppState: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Indicates whether the camera should be opened
    @Published var shouldOpenCamera = false
    
    /// Indicates whether the app is in a loading state
    @Published var isLoading = false
    
    /// Current error message to display
    @Published var errorMessage: String?
    
    // MARK: - Initializer
    
    init() {
        // Initialize with default values
    }
    
    // MARK: - Public Methods
    
    /// Opens the camera interface
    func openCamera() {
        shouldOpenCamera = true
    }
    
    /// Closes the camera interface
    func closeCamera() {
        shouldOpenCamera = false
    }
    
    /// Sets an error message to display
    /// - Parameter message: The error message to display
    func setError(_ message: String) {
        errorMessage = message
    }
    
    /// Clears any current error message
    func clearError() {
        errorMessage = nil
    }
    
    /// Sets the loading state
    /// - Parameter loading: Whether the app is in a loading state
    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
}
