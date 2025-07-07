//
//  UIImage+Extension.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import UIKit

extension UIImage {
    
    // MARK: - Image Resizing
    
    /// Resizes the image to fit within the specified pixel dimensions while maintaining aspect ratio
    /// - Parameter maxPixelDimension: The maximum pixel dimension (width or height)
    /// - Returns: Resized UIImage if successful, nil if resizing fails
    func resized(to maxPixelDimension: CGFloat) -> UIImage? {
        let scale = UIScreen.main.scale
        let maxValue = maxPixelDimension / scale
        
        // Return original image if it's already smaller than the target size
        guard size.height > maxValue || size.width > maxValue else {
            return self
        }
        
        // Calculate the scaling ratio to fit within the target dimensions
        let heightRatio = size.height / maxValue
        let widthRatio = size.width / maxValue
        let ratio = max(heightRatio, widthRatio)
        
        let newSize = CGSize(
            width: size.width / ratio,
            height: size.height / ratio
        )
        
        // Create resized image using UIGraphicsImageRenderer
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return resizedImage
    }
}
