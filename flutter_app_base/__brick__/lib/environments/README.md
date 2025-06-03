# Flutter Environment Configuration System

This document describes the environment configuration system used in the application to manage different environments (Development, Staging, and Production).

## Overview

The system provides a flexible way to manage environment-specific configurations such as API URLs, feature flags, and other environment variables. It supports three environments out of the box:

- Development (dev)
- Staging (stg)
- Production (prod)

## File Structure

```
lib/
├── core/
│   └── environments/
│       ├── env_vars.dart         # Abstract base class defining environment variables
│       ├── env_config.dart       # Main configuration handler
│       ├── env_config_dev.dart   # Development environment configuration
│       ├── env_config_stg.dart   # Staging environment configuration
│       └── env_config_prod.dart  # Production environment configuration
```

## Implementation Details

### Base Configuration (env_vars.dart)

```dart
abstract class EnvVars {
  String get envName;
  String get apiUrl;
  // Add more environment variables as needed
}
```

### Environment-Specific Configurations

Each environment (dev, stg, prod) has its own configuration class implementing `EnvVars`:

```dart
class DevConfig implements EnvVars {
  @override
  String get envName => 'Development';

  @override
  String get apiUrl => 'https://api-dev.example.com';
}
```

### Configuration Handler (env_config.dart)

The `EnvConfig` class manages the environment selection and provides access to the current environment's configuration:

```dart
class EnvConfig {
  static const _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  static final EnvVars _instance = _getConfig();

  static EnvVars _getConfig() {
    switch (_flavor.toLowerCase()) {
      case 'prod':
        return ProdConfig();
      case 'stg':
        return StgConfig();
      default:
        return DevConfig();
    }
  }
}
```

## Usage

### Running the App

To run the app in a specific environment, use the `--dart-define` flag:

```bash
# Development
flutter run --dart-define=FLAVOR=dev

# Staging
flutter run --dart-define=FLAVOR=stg

# Production
flutter run --dart-define=FLAVOR=prod
```

### IDE Configuration (VS Code)

Add these configurations to your `launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=stg"]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=prod"]
    }
  ]
}
```

### Using Environment Variables in Code

Access environment variables through the `EnvConfig` class:

```dart
// Get the API URL for the current environment
final apiUrl = EnvConfig.apiUrl;

// Check current environment
if (EnvConfig.isProd) {
  // Production-specific logic
} else if (EnvConfig.isStg) {
  // Staging-specific logic
} else {
  // Development-specific logic
}
```

## Adding New Environment Variables

To add a new environment variable, you need to follow these steps:

1. Add the new variable to the `EnvVars` abstract class:

```dart
abstract class EnvVars {
  String get envName;
  String get apiUrl;
  String get newVariable; // Add your new variable here
}
```

2. Add the getter in the `EnvConfig` class:

```dart
class EnvConfig {
  // ... existing code ...

  static String get envName => _instance.envName;
  static String get apiUrl => _instance.apiUrl;
  static String get newVariable => _instance.newVariable; // Add new getter
}
```

3. Implement the new variable in each environment configuration class:

````dart
// In env_config_dev.dart
class DevConfig implements EnvVars {
  @override
  String get envName => 'Development';

  @override
  String get apiUrl => 'https://api-dev.example.com';

  @override
  String get newVariable => 'dev-value';
}

// In env_config_stg.dart
class StgConfig implements EnvVars {
  @override
  String get envName => 'Staging';

  @override
  String get apiUrl => 'https://api-staging.example.com';

  @override
  String get newVariable => 'staging-value';
}

// In env_config_prod.dart
class ProdConfig implements EnvVars {
  @override
  String get envName => 'Production';

  @override
  String get apiUrl => 'https://api.example.com';

  @override
  String get newVariable => 'production-value';
}

## Adding New Environments

To add a new environment:

1. Create a new configuration class implementing `EnvVars`
2. Add the new case in the `_getConfig()` method in `EnvConfig`
3. Add a helper method in `EnvConfig` if needed

## Best Practices

1. Always use the `EnvConfig` class to access environment variables
2. Don't hardcode environment-specific values in the code
3. Keep sensitive information out of the configuration files
4. Document any new environment variables added to the system
5. Use meaningful names for environment variables

## Security Considerations

1. Never commit sensitive information (API keys, secrets) in these files
2. Use secure storage or environment variables for sensitive data
3. Consider using encryption for sensitive configuration values

## Building the App

### Development Builds

You can build the app in two ways:

1. Using only --dart-define:
```bash
# Without specifying flavor (defaults to dev)
flutter build apk

# Specifying environment
flutter build apk --dart-define=FLAVOR=dev
````

2. Using both Flutter flavors and dart-define (recommended):

```bash
# Development
flutter build apk --flavor dev --dart-define=FLAVOR=dev

# Staging
flutter build apk --flavor stg --dart-define=FLAVOR=stg

# Production
flutter build apk --flavor prod --dart-define=FLAVOR=prod
```

For release builds:

```bash
# Development
flutter build apk --release --flavor dev --dart-define=FLAVOR=dev

# Staging
flutter build apk --release --flavor stg --dart-define=FLAVOR=stg

# Production
flutter build apk --release --flavor prod --dart-define=FLAVOR=prod
```

Note: To use Flutter flavors (--flavor flag), you need to configure your Android and iOS projects accordingly:

For Android, in `android/app/build.gradle`:

```gradle
android {
    ...
    flavorDimensions "environment"
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            resValue "string", "app_name", "App Dev"
        }
        stg {
            dimension "environment"
            applicationIdSuffix ".stg"
            resValue "string", "app_name", "App Stg"
        }
        prod {
            dimension "environment"
            resValue "string", "app_name", "App"
        }
    }
}
```

For iOS, you'll need to configure the schemes in Xcode accordingly.

### Split APKs by ABI

```bash
# Build split APKs for production
flutter build apk --release --split-per-abi --dart-define=FLAVOR=prod

# This will generate:
# - app-armeabi-v7a-release.apk
# - app-arm64-v8a-release.apk
# - app-x86_64-release.apk
```

### App Bundle

```bash
# Build app bundle for production
flutter build appbundle --release --dart-define=FLAVOR=prod
```

### iOS Builds

```bash
# Build iOS release
flutter build ios --release --dart-define=FLAVOR=prod
```

## Troubleshooting

Common issues and solutions:

1. **Wrong Environment Loading**: Verify the `--dart-define=FLAVOR` argument is correctly set
2. **Missing Variables**: Ensure all environment configurations implement all variables defined in `EnvVars`
3. **Build Issues**: Clean the project and rebuild if environment changes don't take effect

# Flutter Android Flavor Support

## Implementation

Flavor support in the Flutter application (Android) is configured through three files:

### 1. android/app/flavor_config.gradle

File containing the flavors configuration (dev, stg, prod), defining suffixes and names for each environment.

### 2. android/app/build.gradle

```groovy
// Import flavors configuration
apply from: 'flavor_config.gradle'

android {
    ...
    // Apply configuration
    applyFlavors(android)
}
```

### 3. android/app/src/main/AndroidManifest.xml

```xml
<application
    android:label="@string/app_name"
    ... >
```

This configuration allows handling different application variants based on the development environment.
