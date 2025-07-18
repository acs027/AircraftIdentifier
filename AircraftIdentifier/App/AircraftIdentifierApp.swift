//
//  AircraftIdentifierApp.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI
import AppIntents

/// Main application entry point
@main
struct AircraftIdentifierApp: App {
    
    // MARK: - Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @StateObject private var appState = AppState()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(appState)
                .onAppear {
                    handleAppLaunch()
                }
        }
    }
    
    // MARK: - Private Methods
    
    /// Handles app launch logic
    private func handleAppLaunch() {
        if UserDefaults.standard.bool(forKey: "shouldOpenCamera") {
            appState.openCamera()
            UserDefaults.standard.set(false, forKey: "shouldOpenCamera")
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @StateObject var appState = AppState()
    
    return AppTabView()
        .environmentObject(appState)
}
