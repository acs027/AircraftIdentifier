//
//  UIKitCamera.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 21.06.2025.
//

import SwiftUI
import UIKit
import AVFoundation

/// SwiftUI wrapper for UIImagePickerController camera functionality
struct UIKitCamera: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        imagePicker.accessibilityLabel = "Camera"
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // MARK: - Coordinator
    
    /// Coordinator for handling UIImagePickerController delegate methods
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        // MARK: - Properties
        
        let parent: UIKitCamera
        
        // MARK: - Initializer
        
        init(parent: UIKitCamera) {
            self.parent = parent
        }
        
        // MARK: - UIImagePickerControllerDelegate
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var selectedImage: UIImage?
    
    return UIKitCamera(selectedImage: $selectedImage)
}

