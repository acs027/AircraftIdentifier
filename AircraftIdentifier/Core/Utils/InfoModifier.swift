//
//  InfoModifier.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.09.2025.
//

import SwiftUI

struct InfoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWidth(.condensed)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundColor(.primary)
    }
}
