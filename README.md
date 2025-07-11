# AircraftIdentifier

An iOS application for identifying aircraft from photos using AI-powered image analysis.

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

## 🖼️ Showcase

<p align="center">
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 15 17" src="https://github.com/user-attachments/assets/5f290c88-992b-4dfe-988f-afbfc4eef02d" width="300" />
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 19 02" src="https://github.com/user-attachments/assets/101c4121-72a4-43fa-adc6-65c7b2be2239" width="300" />
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 18 42" src="https://github.com/user-attachments/assets/251ab463-d2b5-4720-8484-fc91089d16e6" width="300" />
</p>

### 🎥 Demo

![Demo](https://github.com/user-attachments/assets/baeeed8d-4838-446b-a0c7-07306285a5ff)

### 🧩 Shortcuts
![shortcutIdentifyOpenCamera](https://github.com/user-attachments/assets/c9b22eee-3e04-4705-9495-0f8a774bef2b)
![shortcutIdentifyLastPhoto](https://github.com/user-attachments/assets/7f7dec99-5548-4562-aceb-b1489bc74ab3)
![shortcutIdentifyAircraft](https://github.com/user-attachments/assets/569c6340-9f79-496c-911b-c4b36709a1d4)

### 🗣 Siri
![siriOpenCamera](https://github.com/user-attachments/assets/f1a2903b-f1d1-44e3-9209-eb3638cd08ec)
![siriLastPhoto](https://github.com/user-attachments/assets/527ef3b8-35aa-4d25-a7a3-590918b18cf6)



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
