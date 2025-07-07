//
//  AppDelegate.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

/// Application delegate for handling app lifecycle and Firebase configuration
final class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        configureFirebase()
        return true
    }
    
    // MARK: - Private Methods
    
    /// Configures Firebase services including App Check
    private func configureFirebase() {
        // Configure App Check for security
        let providerFactory = AircraftIdentifierAppCheckProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        // Configure Firebase
        FirebaseApp.configure()
    }
}
