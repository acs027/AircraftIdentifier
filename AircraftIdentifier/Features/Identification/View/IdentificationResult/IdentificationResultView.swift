//
//  ResponseView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 23.06.2025.
//

import SwiftUI

struct IdentificationResultView: View {
    @ObservedObject var vm: PromptViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.clear)
            .background {
                LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .overlay {
                switch vm.responseState {
                case .empty:
                    EmptyView()
                case .loading(_):
                    ProgressView()
                case .success(let aircraftList):
                    ForEach(aircraftList, id: \.id) {
                        aircraft in
                        AircraftInfoView(aircraft: aircraft)
                    }
                    .scrollContentBackground(.hidden)
                case .failure(let error):
                    Text(error.localizedDescription)
                }
            }
    }
}



