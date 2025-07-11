//
//  ContentView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI

/// Main content view of the application
struct ContentView: View {
    
    // MARK: - Environment Objects
    
    @EnvironmentObject private var appState: AppState
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            IdentificationView()
                .navigationTitle("Aircraft Identifier")
                .navigationBarTitleDisplayMode(.large)
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
    
    return ContentView()
        .environmentObject(appState)
}
