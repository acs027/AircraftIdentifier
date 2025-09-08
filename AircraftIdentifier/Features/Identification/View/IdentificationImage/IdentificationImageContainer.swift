//
//  IdentificationImageContainer.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.09.2025.
//

import SwiftUI

struct IdentificationImageContainer: View {
    
    // MARK: - Properties
    
    let imageState: IdentificationViewModel.ImageState
    
    // MARK: - Body
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay {
                IdentificationImageStateView(imageState: imageState)
                    .scaledToFill()
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .accessibilityElement(children: .contain)
    }
}
