//
//  IdentificationImageView.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import SwiftUI
import PhotosUI

/// View for editing and displaying prompt images with animated magnifying glass
struct IdentificationImageView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: IdentificationViewModel
    @State private var positionIndex = 0
    @State private var timer: Timer?
    
    // MARK: - Constants
    
    private let glassSize: CGFloat = 80
    private let animationDuration: TimeInterval = 1.2
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            let positions = calculatePositions(for: geometry)
            
            IdentificationImageContainer(imageState: viewModel.imageState)
                .overlay(alignment: .bottomTrailing) {
                    photoPickerButton
                }
                .overlay(alignment: .topLeading) {
                    magnifyingGlassView(at: positions[positionIndex])
                }
        }
        .frame(maxHeight: .infinity)
        .onChange(of: viewModel.responseState.isLoading) { _, isLoading in
            if isLoading {
                startLoopingAnimation()
            } else {
                stopAnimation()
            }
        }
        .onDisappear {
            stopAnimation()
        }
    }
    
    // MARK: - Private Views
    
    /// Photo picker button for selecting images
    private var photoPickerButton: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(systemName: "pencil.circle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 50))
                .foregroundColor(.accentColor)
        }
        .padding()
        .buttonStyle(.borderless)
        .accessibilityLabel("Select photo")
        .accessibilityHint("Choose an image from your photo library")
    }
    
    /// Animated magnifying glass view
    /// - Parameter position: The position for the magnifying glass
    /// - Returns: The magnifying glass view
    private func magnifyingGlassView(at position: CGSize) -> some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: glassSize, height: glassSize)
            .shadow(radius: 1)
            .offset(position)
            .animation(.easeInOut(duration: animationDuration), value: positionIndex)
            .opacity(viewModel.responseState.isLoading ? 1 : 0)
            .accessibilityHidden(true)
    }
    
    // MARK: - Private Methods
    
    /// Calculates the four corner positions for the magnifying glass animation
    /// - Parameter geometry: The geometry reader proxy
    /// - Returns: Array of positions for the four corners
    private func calculatePositions(for geometry: GeometryProxy) -> [CGSize] {
        let width = geometry.size.width
        let height = geometry.size.height
        let maxX = width - glassSize
        let maxY = height - glassSize
        
        return [
            CGSize(width: glassSize, height: glassSize),                    // top-left
            CGSize(width: maxX - glassSize, height: glassSize),             // top-right
            CGSize(width: glassSize, height: maxY - glassSize),             // bottom-left
            CGSize(width: maxX - glassSize, height: maxY - glassSize)       // bottom-right
        ]
    }
    
    /// Starts the looping animation for the magnifying glass
    private func startLoopingAnimation() {
        guard timer == nil else { return } // Prevent multiple timers
        
        timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            positionIndex = (positionIndex + 1) % 4
        }
    }
    
    /// Stops the animation and cleans up the timer
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Preview

#Preview {
    @Previewable @StateObject var viewModel = IdentificationViewModel()
    
    return IdentificationImageView(viewModel: viewModel)
        .frame(height: 300)
}
