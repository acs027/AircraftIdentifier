//
//  TitleBgGradient.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 6.09.2025.
//

import SwiftUI

struct Gradients {
    static let identificationResultBgGradient = LinearGradient(
        colors: [.yellow, .orange],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let titleViewBgGradient: LinearGradient =  LinearGradient(
        colors: [.blue, .gray],
        startPoint: .leading,
        endPoint: .trailing
    )
}


