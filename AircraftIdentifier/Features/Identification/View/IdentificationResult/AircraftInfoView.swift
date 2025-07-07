//
//  AircraftInfoView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import SwiftUI

/// View for displaying detailed aircraft information
struct AircraftInfoView: View {
    
    // MARK: - Properties
    
    let aircraft: Aircraft
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                aircraftTypeSection
                aircraftRoleSection
                airlineSection
                engineTypeSection
                distinctiveFeaturesSection
                confidenceSection
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Aircraft information for \(aircraft.aircraftType)")
    }
    
    // MARK: - Private Views
    
    /// Aircraft type information section
    private var aircraftTypeSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Aircraft Type")
            infoView(aircraft.aircraftType)
        }
    }
    
    /// Aircraft role information section
    private var aircraftRoleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Aircraft Role")
            infoView(aircraft.aircraftRole)
        }
    }
    
    /// Airline information section
    private var airlineSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Airline")
            infoView(aircraft.airline)
        }
    }
    
    /// Engine type information section
    private var engineTypeSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Engine Type")
            infoView(aircraft.engineType)
        }
    }
    
    /// Distinctive features information section
    private var distinctiveFeaturesSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Distinctive Features")
            infoView(aircraft.distinctiveFeatures)
        }
    }
    
    /// Confidence score section
    private var confidenceSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView("Confidence Score")
            HStack {
                Text("\(aircraft.confidenceScore)%")
                    .font(.headline)
                    .foregroundColor(confidenceColor)
                
                Spacer()
                
                confidenceIndicator
            }
        }
    }
    
    /// Confidence indicator view
    private var confidenceIndicator: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Circle()
                    .fill(index < confidenceLevel ? Color.green : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Creates a title view with consistent styling
    /// - Parameter title: The title text
    /// - Returns: A styled title view
    private func titleView(_ title: String) -> some View {
        Rectangle()
            .frame(height: 25)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [.blue, .gray],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundStyle(.clear)
            .overlay {
                Text(title)
                    .fontWidth(.expanded)
                    .fontWeight(.black)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    /// Creates an info view with consistent styling
    /// - Parameter text: The information text
    /// - Returns: A styled info view
    private func infoView(_ text: String) -> some View {
        Text("- \(text)")
            .fontWidth(.condensed)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundColor(.primary)
    }
    
    // MARK: - Computed Properties
    
    /// Confidence level based on score (0-4)
    private var confidenceLevel: Int {
        min(4, aircraft.confidenceScore / 20)
    }
    
    /// Color for confidence score display
    private var confidenceColor: Color {
        switch aircraft.confidenceScore {
        case 80...100:
            return .green
        case 60..<80:
            return .orange
        default:
            return .red
        }
    }
}

// MARK: - Preview

#Preview {
    let sampleAircraft = Aircraft(
        aircraftType: "Airbus A320",
        airline: "Wizz Air",
        engineType: "Turbofan",
        distinctiveFeatures: "White fuselage with magenta accents on tail and wingtips",
        aircraftRole: "Commercial passenger transport",
        registrationNumber: "HA-LWA",
        countryOfOrigin: "European Union",
        confidenceScore: 85
    )
    
    return AircraftInfoView(aircraft: sampleAircraft)
        .padding()
}
