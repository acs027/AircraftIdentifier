//
//  AircraftIdentifierAppCheck.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import Foundation
import FirebaseAppCheck
import FirebaseCore

class AircraftIdentifierAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    #if targetEnvironment(simulator)
      return AppCheckDebugProvider(app: app)
    #else
      return AppAttestProvider(app: app)
  #endif
  }
}
