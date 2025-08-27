# GameMaster Pro

A sophisticated Flutter application built with Bloc/Cubit architecture to create a modular, maintainable mobile experience. The app features a startup screen for initialization, a home screen with counter functionality, and comprehensive state management. Key functionalities include flavor configuration (development and production), basic Bloc state management demonstrating core interaction patterns, and template components for rapid development.

## 🌟 Features

- **Bloc/Cubit Architecture**: Implements clean state management using Flutter Bloc pattern
- **Flavor Configuration**: Supports both development and production environments
- **Template Components**: Pre-built UI components (buttons, cards, tab bars) for rapid development
- **Responsive Design**: Utilizes responsive UI helpers for consistent layout across devices
- **Modern Styling**: Sophisticated color palette and typography system
- **Template Services**: Includes commented templates for Firebase Authentication and Firestore integration

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart 2.17+

### Installation

```bash
flutter pub get
```

### Running the App

**Development Mode:**
```bash
flutter run --flavor development --target lib/main/main_development.dart
```

**Production Mode:**
```bash
flutter run --flavor production --target lib/main/main_production.dart
```

## 🏗️ Architecture

```
lib/
├── app/
│   └── app.dart              # Main application entry point
├── features/
│   ├── home/                 # Home screen with counter functionality
│   │   ├── home_cubit.dart   # Home state management
│   │   ├── home_state.dart   # Home state definitions
│   │   └── home_view.dart    # Home screen UI
│   └── startup/              # Initial loading screen
│       └── startup_view.dart # Startup screen implementation
├── main/
│   ├── bootstrap.dart        # Application bootstrapping
│   ├── main_development.dart # Development entry point
│   └── main_production.dart  # Production entry point
├── models/
│   └── enums/
│       └── flavor.dart       # Application flavor definitions
├── services/                 # Template service implementations
│   ├── firebase_auth_service.dart # Firebase Auth template
│   └── firestore_service.dart     # Firestore template
├── shared/                   # Shared components and utilities
│   ├── app_colors.dart       # Color palette definitions
│   ├── button.dart           # Custom button component
│   ├── card.dart             # Custom card component
│   ├── tab_bar.dart          # Custom tab bar component
│   ├── text_style.dart       # Typography definitions
│   └── ui_helpers.dart       # Responsive UI utilities
└── utils/
    └── flavors.dart          # Flavor configuration utilities
```

### Key Patterns

- **State Management**: Flutter Bloc/Cubit pattern for reactive state management
- **Dependency Injection**: Centralized bootstrapping through `bootstrap.dart`
- **Separation of Concerns**: Clear division between UI, business logic, and state management
- **Template System**: Reusable component templates for rapid development

### Major Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | sdk: flutter | Flutter framework |
| flutter_bloc | ^8.1.3 | State management using Bloc/Cubit pattern |
| equatable | ^2.0.5 | Efficient state comparison for Bloc states |

## 🧪 Development

### Testing

```bash
flutter test
```

### Code Formatting

```bash
flutter format .
```

### Building

**Android:**
```bash
flutter build apk --flavor development
flutter build apk --flavor production
```

**iOS:**
```bash
flutter build ios --flavor development
flutter build ios --flavor production
```

## 📄 Contributing & License

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Note**: This application serves as a template with pre-built architecture and components. Some files are marked as templates and should be customized for specific application requirements.