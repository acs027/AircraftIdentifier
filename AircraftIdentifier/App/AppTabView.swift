//
//  AppTabBar.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 27.06.2025.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Tab = .prompt
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                prompt
                settings
            }
        }
    }
    
    
    var prompt: some View {
        ContentView()
                .navigationBarTitleDisplayMode(.inline)
        .tabItem {
            Label(Tab.prompt.rawValue,
                  systemImage: Tab.prompt.systemImage)
        }
        .tag(Tab.prompt)
    }
    
    var settings: some View {
        ProgressView()
            .navigationBarTitleDisplayMode(.inline)
            .tabItem {
                Label(Tab.settings.rawValue, systemImage: Tab.settings.systemImage)
            }
            .tag(Tab.settings)
    }
}

enum Tab: String, CaseIterable {
    case prompt = "Converters"
    case settings = "Settings"
    
    
    var systemImage: String {
        switch self {
        case .prompt:
            return "house"
        case .settings:
            return "arrow.2.squarepath"
        }
    }
}

#Preview {
    AppTabView()
}
