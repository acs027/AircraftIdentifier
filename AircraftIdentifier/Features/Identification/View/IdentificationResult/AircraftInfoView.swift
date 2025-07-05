//
//  AircraftInfoView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//
import SwiftUI

struct AircraftInfoView: View {
    let aircraft: Aircraft
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                
                title(string: "Aircraft Types")
                info(string: aircraft.aircraftType)
                
                title(string: "Aircraft Role")
                info(string: aircraft.aircraftRole)
                
                title(string: "Airline")
                info(string: aircraft.airline)

                title(string: "Engine Type")
                info(string: aircraft.engineType)
           
                title(string: "Distinctive Features")
                info(string: aircraft.distinctiveFeatures)
            }
        }
        .padding()
    }
    private func title(string: String) -> some View {
        Rectangle()
            .frame(height: 25)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.blue, .gray], startPoint: .leading, endPoint: .trailing))
            .foregroundStyle(.clear)
            .overlay {
                Text(string)
                    .fontWidth(.expanded)
                    .fontWeight(.black)
                    .fontDesign(.rounded)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    private func info(string: String) -> some View {
        Text("-" + string)
            .fontWidth(.condensed)
            .fontWeight(.medium)
            .fontDesign(.rounded)
    }
}
