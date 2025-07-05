//
//  CircleClipModifier.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.07.2025.
//

import SwiftUI

struct CircleClipModifier: ViewModifier {
    var progress: CGFloat

    func body(content: Content) -> some View {
        GeometryReader {
            proxy in
            
            let size = proxy.size
            let maxRadius = sqrt(size.width * size.width + size.height * size.height)
            
            content
                .clipShape(CircleRevealShape(radius: maxRadius * progress))
        }
        
    }
}
