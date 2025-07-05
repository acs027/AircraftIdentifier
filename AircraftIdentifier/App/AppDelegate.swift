//
//  AppDelegate.swift
//  AircraftIdentifier
//
//  Created by ali cihan on 8.06.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      let providerFactory = AircraftIdentifierAppCheckProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)
    FirebaseApp.configure()

    return true
  }
}
