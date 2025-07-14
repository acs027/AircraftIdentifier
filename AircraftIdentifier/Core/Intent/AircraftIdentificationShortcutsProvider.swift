//
//  AircraftIdentificationShortcutsProvider.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 4.07.2025.
//


import AppIntents

// MARK: - Enhanced Shortcuts Provider

struct AircraftIdentificationShortcutsProvider: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: SelectPhotoAndIdentifyAircraftIntent(),
            phrases: [
                "bla bla bla bla in \(.applicationName)"
            ],
            shortTitle: "Identify Aircraft",
            systemImageName: "airplane"
        )
        
        AppShortcut(
            intent: IdentifyLastPhotoIntent(),
            phrases: [
                "Identify my last photo in \(.applicationName)",
                "What's in my last photo in \(.applicationName)",
                "Identify the last aircraft photo in \(.applicationName)"
            ],
            shortTitle: "Identify Last Photo",
            systemImageName: "photo"
        )
        
        AppShortcut(
            intent: OpenCameraIntent(),
            phrases: [
                "Take aircraft photo in \(.applicationName)",
                "Open camera in \(.applicationName)",
                "Take a picture in \(.applicationName)"
            ],
            shortTitle: "Take Photo",
            systemImageName: "camera"
        )
    }
}
