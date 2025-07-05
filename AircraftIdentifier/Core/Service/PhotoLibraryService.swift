//
//  AircraftIdentifierService.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 1.07.2025.
//

import Foundation
import Photos
import UIKit

// MARK: - Fetch and Resize Last Photo
final class PhotoLibraryService {
    static let shared = PhotoLibraryService()
    
    func requestPhotoLibraryAccess() async -> Bool {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .authorized, .limited:
            return true
        case .notDetermined:
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return newStatus == .authorized || newStatus == .limited
        default:
            return false
        }
    }
    
    func fetchAndResizeLastPhoto(maxPixel: CGFloat = 3200) async -> UIImage? {
        
        guard await requestPhotoLibraryAccess() else {
            print("❌ Photo Library access denied")
            return nil
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 1

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        guard let asset = fetchResult.firstObject else {
            print("❌ No images found")
            return nil
        }

        return await withCheckedContinuation { continuation in
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true

            manager.requestImage(
                for: asset,
                targetSize: PHImageManagerMaximumSize,
                contentMode: .aspectFit,
                options: options
            ) { image, _ in
                guard let image else {
                    print("❌ Failed to get image")
                    continuation.resume(returning: nil)
                    return
                }

                let resizedImage = image.resized(to: maxPixel)
                continuation.resume(returning: resizedImage)
            }
        }
    }
    
    
}
