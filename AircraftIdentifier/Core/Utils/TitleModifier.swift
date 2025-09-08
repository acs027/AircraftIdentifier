//
//  TitleModifier.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.09.2025.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWidth(.expanded)
            .fontWeight(.black)
            .fontDesign(.rounded)
            .foregroundColor(.white)
    }
}


