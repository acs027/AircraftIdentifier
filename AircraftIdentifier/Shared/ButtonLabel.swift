//
//  ButtonLabel.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import SwiftUI

struct ButtonLabel: View {
    let imageSystemName: String
    
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
    }
}
