//
//  AircraftIdentifierApp.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI
import AppIntents

@main
struct AircraftIdentifierApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    if UserDefaults.standard.bool(forKey: "shouldOpenCamera") {
                        appState.shouldOpenCamera = true
                        UserDefaults.standard.set(false, forKey: "shouldOpenCamera")
                    }
                }
        }
    }
    
}

#Preview {
    @Previewable @StateObject var appState = AppState()
//    AppTabView()
    ContentView()
        .environmentObject(appState)
}
