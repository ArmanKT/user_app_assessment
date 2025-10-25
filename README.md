# Sokrio - User App Assessment

Flutter assessment that demonstrates Clean Architecture and BLoC by fetching and displaying a list of users. The goal is to show a well-structured, testable implementation that is easy to extend.

Goals
- Implement a paginated user list UI with loading and error states
- Apply Clean Architecture layers: presentation, domain, data
- Use BLoC for state management and separation of concerns
- Wire up dependency injection (GetIt) and routing (GoRouter)
- Cache results locally and handle offline/online states


## 🎯 Architecture Overview

The application follows a clean architecture pattern with clear separation of concerns:

### 1. Presentation Layer (`features/*/presentation/`)
- Contains all UI components and state management logic
- Uses BLoC pattern for managing state
- Features are organized in separate modules

### 2. Domain Layer (`features/*/domain/`)
- Contains business logic and use cases
- Defines repository interfaces

### 3. Data Layer (`features/*/data/`)
- Implements repository interfaces
- Handles data sources (API, local storage)
- Manages data caching and persistence

## 🚀 Features

- Clean Architecture Implementation
- BLoC Pattern for State Management
- Dependency Injection using GetIt
- Routing with GoRouter
- Network Connectivity Handling
- Caching Support
- Responsive UI with Material Design
- Image Caching
- Loading Skeletons for Better UX

## 🛠 Tech Stack

- **Framework**: Flutter (SDK >=3.5.1)
- **State Management**: flutter_bloc (v9.1.1)
- **Navigation**: go_router (v16.3.0)
- **Dependency Injection**: get_it (v8.2.0)
- **Network**: dio (v5.9.0)
- **Local Storage**: hive_ce (v2.15.1)
- **Image Handling**: 
  - cached_network_image (v3.4.1)
  - flutter_svg (v2.2.1)
- **UI Components**:
  - flutter_spinkit (v5.2.2)
  - skeletonizer (v2.1.0)
- **Utils**:
  - connectivity_plus (v7.0.0)
  - logger (v2.6.2)
  - equatable (v2.0.7)

## 📁 Project Structure

```
lib/
├── app/
│   ├── components/      # Shared UI components
│   ├── core/           # Core functionality
│   ├── features/       # Feature modules
│   └── router/         # Navigation routing
├── environment.dart    # Environment configuration
└── main.dart          # Application entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.5.1) Latest
- Dart SDK
- Android Studio / VS Code with Flutter plugins

### Installation & Setup

1. Clone the repository
```bash
git clone https://github.com/ArmanKT/user_app_assessment.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup environment variables (if needed)

4. Run the app
```bash
flutter run
```

### Application Entry Point

The application starts in `main.dart` with the following initialization sequence:

```dart
void main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup BLoC observer for state management debugging
  Bloc.observer = AppBlocObserver();
  
  // Initialize dependency injection
  await ServiceLocator.init();
  
  // Setup routing
  final appRouter = AppRouter();
  
  // Run the app
  runApp(ArcApp(appRouter: appRouter));
}
```

## 🏗 Architecture & Code Organization

### Core Components (`app/core/`)

1. **Dependency Injection (`di/`)**
   - Uses `GetIt` for service location
   - `service_locator.dart`: Centralizes dependency registration
   - `bloc_observer.dart`: Custom BLoC observer for state management debugging

2. **Network (`network/`)**
   - API client configuration
   - Interceptors for authentication
   - Connection state management


### Feature Organization (`app/features/`)

Each feature follows this structure:
```
feature_name/
├── data/
│   ├── datasources/     # API and local data sources
│   ├── models/          # Data models and DTOs
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Business objects
│   ├── repositories/    # Repository interfaces
│   └── usecases/       # Business logic
└── presentation/
    ├── bloc/           # State management
    ├── screens/          # Screen widgets
    └── screens/widgets/        # Reusable UI components
```

### Navigation (`app/router/`)

- Implements GoRouter for declarative routing



## 💻 Development

### Running Tests

```bash
flutter test
```

## 📱 Supported Platforms

- Android
- iOS
- Web
- Linux
- macOS
- Windows


## 👤 Author

- **ArmanKT**
  - GitHub: [@ArmanKT](https://github.com/ArmanKT)
