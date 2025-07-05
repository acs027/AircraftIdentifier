//
//  UIImage+Extension.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import SwiftUI

extension UIImage {
    func resized(to pixel: CGFloat) -> UIImage? {
        let scale = UIScreen.main.scale
        print(self.size.height, self.size.width)
        print(scale)
        let maxValue = pixel / scale
        if self.size.height < maxValue && self.size.width < maxValue {
            return self
        }
        let heightRatio = self.size.height / maxValue
        let widthRatio = self.size.width / maxValue
        let ratio = max(heightRatio, widthRatio)
        let newSize = CGSize(width: self.size.width / ratio, height: self.size.height / ratio)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        print("resized")
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        //        saveToPhotoLibrary(image)
        return image
    }
}
