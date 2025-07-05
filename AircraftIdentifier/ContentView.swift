//
//  ContentView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State var content = ""
    var body: some View {
        NavigationStack {
            IdentificationView()
        }
    }
}

#Preview {
    ContentView()
}
