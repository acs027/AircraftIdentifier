//
//  ResponseView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 23.06.2025.
//

import SwiftUI

/// View for displaying aircraft identification results
struct IdentificationResultView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: IdentificationViewModel
    
    // MARK: - Body
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.clear)
            .background {
                Gradients.identificationResultBgGradient
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .overlay {
                contentView
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Aircraft identification results")
    }
    
    // MARK: - Private Views
    
    /// Content view based on response state
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.responseState {
        case .empty:
            EmptyView()
                .accessibilityHidden(true)
            
        case .loading:
            ProgressView()
                .accessibilityLabel("Analyzing aircraft image")
            
        case .success(let aircraftList):
            if aircraftList.isEmpty {
                noAircraftFoundView
            } else {
                aircraftListView(aircraftList)
            }
            
        case .failure(let error):
            errorView(error)
        }
    }
    
    /// View for when no aircraft are found
    private var noAircraftFoundView: some View {
        VStack(spacing: 12) {
            Image(systemName: "airplane.circle")
                .font(.system(size: 48))
            
            Text(AppConstants.IdentificationResult.aircraftNotFound)
                .font(.headline)
            
            Text(AppConstants.IdentificationResult.aircraftNotFoundDescripton)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(AppConstants.IdentificationResult.textColor)
        .padding()
        .accessibilityLabel("No aircraft found in image")
    }
    
    /// View for displaying the list of identified aircraft
    private func aircraftListView(_ aircraftList: [Aircraft]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(aircraftList) { aircraft in
                    AircraftInfoView(aircraft: aircraft)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Aircraft: \(aircraft.aircraftType)")
                }
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
    }
    
    /// View for displaying errors
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(AppConstants.IdentificationResult.errorColor)
            
            Text(AppConstants.IdentificationResult.failedText)
                .modifier(TitleModifier())
            
            Text(error.localizedDescription)
                .font(.body)
                .foregroundColor(AppConstants.IdentificationResult.textColor)
                .multilineTextAlignment(.center)
        }
        .padding()
        .accessibilityLabel("Analysis failed: \(error.localizedDescription)")
    }
}

// MARK: - Preview

#Preview {
    @Previewable @StateObject var viewModel = IdentificationViewModel()
    
    return IdentificationResultView(viewModel: viewModel)
}



