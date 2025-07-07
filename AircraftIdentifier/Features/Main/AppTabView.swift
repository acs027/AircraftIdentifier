//
//  AppTabView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 27.06.2025.
//

import SwiftUI

/// Main tab view for the application
struct AppTabView: View {
    
    // MARK: - State Properties
    
    @State private var selectedTab: Tab = .identification
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            identificationTab
            settingsTab
        }
        .accessibilityElement(children: .contain)
    }
    
    // MARK: - Private Views
    
    /// Aircraft identification tab
    private var identificationTab: some View {
        NavigationView {
            ContentView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .tabItem {
            Label(Tab.identification.title, systemImage: Tab.identification.systemImage)
        }
        .tag(Tab.identification)
        .accessibilityLabel("Aircraft identification")
    }
    
    /// Settings tab
    private var settingsTab: some View {
        SettingsView()
            .tabItem {
                Label(Tab.settings.title, systemImage: Tab.settings.systemImage)
            }
            .tag(Tab.settings)
            .accessibilityLabel("Settings")
    }
}

// MARK: - Tab Enumeration

/// Available tabs in the application
enum Tab: String, CaseIterable {
    case identification = "Identification"
    case settings = "Settings"
    
    /// Display title for the tab
    var title: String {
        rawValue
    }
    
    /// SF Symbol name for the tab icon
    var systemImage: String {
        switch self {
        case .identification:
            return "airplane.circle"
        case .settings:
            return "gear"
        }
    }
}

// MARK: - Preview

#Preview {
    AppTabView()
        .environmentObject(AppState())
}
