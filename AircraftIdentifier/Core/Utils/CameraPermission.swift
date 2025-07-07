//
//  CameraPermission.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 21.06.2025.
//

import Foundation
import UIKit
import AVFoundation

/// Utility for handling camera permissions
enum CameraPermission {
    
    // MARK: - Error Types
    
    /// Errors that can occur during camera permission checks
    enum CameraError: LocalizedError {
        case unauthorized
        case unavailable
        
        var errorDescription: String? {
            switch self {
            case .unauthorized:
                return NSLocalizedString(
                    "Camera access is not authorized",
                    comment: "Camera permission denied error"
                )
            case .unavailable:
                return NSLocalizedString(
                    "Camera is not available on this device",
                    comment: "Camera unavailable error"
                )
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .unauthorized:
                return "Open Settings > Privacy and Security > Camera and enable access for this app."
            case .unavailable:
                return "Use the photo library instead to select an existing image."
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Checks camera permissions and availability
    /// - Returns: CameraError if there's a permission issue, nil otherwise
    static func checkPermissions() -> CameraError? {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return .unavailable
        }
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authStatus {
        case .notDetermined, .restricted:
            return nil
        case .denied:
            return .unauthorized
        case .authorized:
            return nil
        @unknown default:
            return nil
        }
    }
    
    /// Requests camera permission if not determined
    /// - Returns: True if permission is granted, false otherwise
    static func requestPermission() async -> Bool {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        return granted
    }
}
