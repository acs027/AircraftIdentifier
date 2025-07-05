//
//  CircleRevealShape.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.07.2025.
//

import SwiftUI

struct CircleRevealShape: Shape {
    var radius: CGFloat

    var animatableData: CGFloat {
        get { radius }
        set { radius = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addEllipse(in: CGRect(
                x: rect.midX - radius / 2,
                y: rect.midY - radius / 2,
                width: radius,
                height: radius
            ))
        }
    }
}




