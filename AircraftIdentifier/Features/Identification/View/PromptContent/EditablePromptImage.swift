//
//  EditablePromptImage.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//
import SwiftUI
import PhotosUI

struct EditablePromptImage: View {
    @ObservedObject var viewModel: PromptViewModel
    @State private var positionIndex = 0
    @State private var timer: Timer?
    let glassSize: CGFloat = 80
    
    var body: some View {
        GeometryReader {  geo in
            let width = geo.size.width
            let height = geo.size.height
            let maxX = width - glassSize
            let maxY = height - glassSize
            
            // 4 corner positions
            let positions: [CGSize] = [
                CGSize(width: glassSize, height: glassSize),           // top-left
                CGSize(width: maxX - glassSize, height: glassSize),        // top-right
                CGSize(width: glassSize, height: maxY - glassSize),        // bottom-left
                CGSize(width: maxX - glassSize, height: maxY - glassSize)      // bottom-right
            ]
            
            
            PromptImageContainer(imageState: viewModel.imageState)
                .overlay(alignment: .bottomTrailing) {
                    PhotosPicker(selection: $viewModel.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 50))
                            .foregroundColor(.accentColor)
                    }
                                 .padding()
                                 .buttonStyle(.borderless)
                }
                .overlay(alignment: .topLeading) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: glassSize, height: glassSize)
                        .offset(positions[positionIndex])
                        .animation(.easeInOut(duration: 1.2), value: positionIndex)
                        .opacity(viewModel.responseState.isLoading ? 1 : 0)
                }
        }
        .frame(maxHeight: .infinity)
        .onChange(of: viewModel.responseState.isLoading) { oldValue, newValue in
            if newValue {
                startLoopingAnimation()
            } else {
                stopAnimation()
            }
        }
    }
    
    private func startLoopingAnimation() {
        guard timer == nil else { return } // Prevent multiple timers
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
            positionIndex = (positionIndex + 1) % 4
        }
    }
    
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}
