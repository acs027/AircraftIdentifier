# AircraftIdentifier

An iOS application for identifying aircraft from photos using AI-powered image analysis.

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with the following principles:

### Core Principles
- **Separation of Concerns**: Each layer has a specific responsibility
- **Dependency Injection**: Services are injected where needed
- **Protocol-Oriented Programming**: Using protocols for flexibility
- **Value Types**: Preferring structs over classes for data models

### Layers

1. **Model Layer** (`Core/Model/`)
   - Data structures and business entities
   - Pure Swift structs with Codable conformance

2. **Service Layer** (`Core/Service/`)
   - Business logic and external API interactions
   - Singleton pattern for shared services
   - Async/await for asynchronous operations

3. **ViewModel Layer** (`Features/*/ViewModel/`)
   - State management and business logic
   - ObservableObject for SwiftUI integration
   - Published properties for reactive updates

4. **View Layer** (`Features/*/View/`)
   - SwiftUI views for user interface
   - Declarative UI with accessibility support
   - Modular and reusable components

### Key Features

- **Aircraft Identification**: AI-powered image analysis
- **Camera Integration**: Photo capture and processing
- **Photo Library**: Access to existing photos
- **App Intents**: Siri Shortcuts integration
- **Settings**: User preferences and permissions

### Dependencies

- **SwiftUI**: Modern declarative UI framework
- **Firebase AI**: AI-powered image analysis
- **PhotosUI**: Photo library integration
- **App Intents**: Siri Shortcuts support

## Getting Started

1. Clone the repository
2. Open `AircraftIdentifier.xcodeproj` in Xcode
3. Configure Firebase (add your `GoogleService-Info.plist`)
4. Build and run the project

## Requirements

- iOS 17.0+
- Xcode 15.0+

## Project Structure

```
AircraftIdentifier/
├── App/                          # Application-level files
│   ├── AircraftIdentifierApp.swift
│   ├── AppDelegate.swift
│   ├── AppState.swift
│   └── AppCheck/
│       └── AircraftIdentifierAppCheck.swift
├── Core/                         # Core functionality
│   ├── Model/                    # Data models
│   │   └── Aircraft.swift
│   ├── Service/                  # Business logic services
│   │   ├── AIService.swift
│   │   ├── PhotoLibraryService.swift
│   │   └── JSONParser.swift
│   ├── UI/                       # UIKit components
│   │   └── UIKitCamera.swift
│   ├── Utils/                    # Utility classes
│   │   └── CameraPermission.swift
│   ├── Extension/                # Swift extensions
│   │   └── UIImage+Extension.swift
│   └── Intent/                   # App Intents
│       ├── AircraftIdentifierAppIntent.swift
│       └── AircraftIdentificationShortcutsProvider.swift
├── Features/                     # Feature modules
│   ├── Main/                     # Main feature
│   │   ├── ContentView.swift
│   │   └── AppTabView.swift
│   ├── Identification/           # Aircraft identification feature
│   │   ├── Model/
│   │   │   └── PromptError.swift
│   │   ├── ViewModel/
│   │   │   └── PromptViewModel.swift
│   │   ├── View/
│   │   │   ├── IdentificationView.swift
│   │   │   ├── PromptContent/
│   │   │   │   ├── EditablePromptImage.swift
│   │   │   │   └── PromptImageView.swift
│   │   │   └── IdentificationResult/
│   │   │       ├── IdentificationResultView.swift
│   │   │       └── AircraftInfoView.swift
│   │   └── Animation/
│   │       ├── AnyTransition+CircularReveal.swift
│   │       ├── CircleRevealShape.swift
│   │       └── CircleClipModifier.swift
│   └── Settings/                 # Settings feature
│       └── SettingsView.swift
├── Shared/                       # Shared components
│   ├── ButtonLabel.swift
│   ├── Assets.xcassets/
│   └── Preview Content/
└── Resources/                    # App resources
    ├── Info.plist
    ├── AircraftIdentifier.entitlements
    └── GoogleService-Info.plist
```
