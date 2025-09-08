//
//  ButtonLabel.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import SwiftUI

/// A reusable button label with gradient background and icon
struct ButtonLabel: View {
    
    // MARK: - Properties
    
    let imageSystemName: String
    
    // MARK: - Body
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 75)
            .frame(maxWidth: .infinity)
            .foregroundStyle(
                LinearGradient(
                    colors: [.cyan, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: imageSystemName)
                    .font(.largeTitle)
                    .tint(.primary)
                    .shadow(radius: 1)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(accessibilityLabel)
    }
    
    // MARK: - Computed Properties
    
    /// Accessibility label based on the icon
    private var accessibilityLabel: String {
        switch imageSystemName {
        case "magnifyingglass":
            return "Identify aircraft"
        case "arrow.trianglehead.counterclockwise":
            return "Reset identification"
        case "camera.circle.fill":
            return "Take photo"
        default:
            return "Button"
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        ButtonLabel(imageSystemName: "magnifyingglass")
        ButtonLabel(imageSystemName: "arrow.trianglehead.counterclockwise")
        ButtonLabel(imageSystemName: "camera.circle.fill")
    }
    .padding()
}
