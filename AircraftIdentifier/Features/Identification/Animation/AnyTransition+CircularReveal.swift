//
//  AnyTransition+CircularReveal.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.07.2025.
//

import SwiftUI

extension AnyTransition {
    static var circularReveal: AnyTransition {
        .modifier(
            active: CircleClipModifier(progress: 0),
            identity: CircleClipModifier(progress: 1)
        )
    }
}
