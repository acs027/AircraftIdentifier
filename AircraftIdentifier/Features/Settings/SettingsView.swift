//
//  SettingsView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 27.06.2025.
//

import SwiftUI

/// Settings view for the application
struct SettingsView: View {
    
    // MARK: - State Properties
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("autoSavePhotos") private var autoSavePhotos = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                appearanceSection
                notificationsSection
                privacySection
                aboutSection
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Private Views
    
    /// Appearance settings section
    private var appearanceSection: some View {
        Section("Appearance") {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .accessibilityLabel("Toggle dark mode")
        }
    }
    
    /// Notifications settings section
    private var notificationsSection: some View {
        Section("Notifications") {
            Toggle("Enable Notifications", isOn: $enableNotifications)
                .accessibilityLabel("Toggle notifications")
        }
    }
    
    /// Privacy settings section
    private var privacySection: some View {
        Section("Privacy") {
            Toggle("Auto-save Photos", isOn: $autoSavePhotos)
                .accessibilityLabel("Toggle auto-save photos")
            
            NavigationLink("Camera Permissions") {
                CameraPermissionsView()
            }
            .accessibilityLabel("Camera permissions settings")
        }
    }
    
    /// About section
    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Build")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1")
                    .foregroundColor(.secondary)
            }
        }
    }
}

/// Camera permissions detail view
struct CameraPermissionsView: View {
    
    // MARK: - Body
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Camera Access")
                        .font(.headline)
                    
                    Text("This app needs camera access to identify aircraft in photos you take.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Button("Open Settings") {
                        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Camera Permissions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
} 