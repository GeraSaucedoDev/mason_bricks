## Clean Architecture Principles

- **Separation of Concerns**: Each part of the application has a specific responsibility
- **Dependency Rule**: Dependencies always point inward
- **Abstraction**: Inner layers don't know about outer layers
- **Testability**: Business logic can be tested independently of UI or external services

## Base Architecture

The application structured is based on clean architecture, with the following main folders:

- Core/
- Data/
- Domain/
- Presentation/
- enviroments/
- main_injector.dart
- main_app.dart
- main.dart

### Core

Contains essential infrastructure for the application functioning:

- constants/: Application-wide constants
- localization/: App lengauges support
- navigation/: Navigation configuration
- services/: Core services like analytics, logging, etc.
- theme/: Style definitions
- utils/: Helper functions and extensions (for services)
- etc.

### Data

Contains files used for data extraction or API connections, as well as necessary mappers to convert this data into different models or variables.
Uses the "repository" design pattern for data handling.

- repositories/
- dtos/: DTOs (Data Transfer Objects)
- utils/: Utils to transform received data into new data such StringToEnity, etc (file_data_utils.dart)

### Domain

Contains the necessary files that represent business models or entities.

- models/: Entity models (These models have basic mappers)
- utils/: Files to extract data for complex models, for example getProductName from Model, etc (model_utils.dart)

Note this architecture does not implement model abstraction or use cases, this is for personal opinion and for me makes eaasier to maintain this proyect architecture

### Presentation

- Contains files necessary for application state management, shared widgets, screens, and general views.

- screens/: Full pages with scaffolds and app bars
  - Views/: Content of screens without scaffolding
    - File structure within this folder:
      - file_bloc_listener: For bloc state management listener configurations.
      - file_screen: Contains the code that represents the screen, including the appbar and main design.
      - file_view: Contains the code of what the screen displays, without the appbar or main scaffold.
      - widgets/: Folder containing specific widgets for the module, view, or screen.
- widgets/: Shareable and reusable UI components
- blocs/: State management

### Environments

- Contains configuration for development and production environments.
- Located in lib/environments with 4 files:

  - env_config_dev.dart: Contains variable values for the dev environment.
  - env_config_prod.dart: Contains variable values for the production environment.
  - env_config_stg.dart: Contains variable values for the staging environment.
  - env_config.dart: Configuration file that detects the app's flavor.
  - env_vars.dart: Contains the abstraction of variables to be used.

  HOW THIS WORKS:

  - we going to use dart define variables and flavors, depending of the flavor we going to use enviroment vars to have a unique main entry point

### Additional Files

- main_injector.dart: Dependency injection setup
- main_app.dart: Root Material App configuration
- main.dart: Application bootstrap

## Development Process

When developing a new feature:

(Remember some steps are not necessary, so skip them if needed)

1. Define a entity model
1. Create a service
1. Create a repository
1. Create state management files for the module and connect repository
1. Create ui and connect state manager

# Creating a service

1. Create the service in lib/services for encapsulation if possible.
2. Add the external dependency in lib/main_injector.
3. Add the created service in lib/core/services/services_injector.dart.

# Creating repository

1. Create the repository in lib/data/repositories/name_repository.dart if needed.
2. Add the repository to lib/data/repositories/repositories_injector.dart.

# Creating state manageer

in this case we use bloc

1. Create the corresponding bloc or state in lib/presentation.
2. Add the created bloc to lib/presentation/blocs/bloc_injector.dart.
3. if is a global state, add the created bloc to lib/presentation/blocs/app_bloc_provider.dart.
4. Create necessary screens and widgets in lib/presentation/screens and lib/presentation/widgets.

## Dependency Management

- get_it: Service locator for dependency injection
- Bloc: State management
- go_router: Navigation
- Formz: Form management
- dio: HTTP client

## Additional Information

- Uses get_it package as a service locator for dependency injection.
- The main file for services, repositories, blocs, etc., is /lib/main_injector.dart.
- Uses Bloc for state management, go_router for navigation, Formz for forms managent, and dio as API client.

## Additional Considerations

- Encapsulate external dependencies to avoid strong coupling
- Handle sensitive data securely
- Consider accessibility in UI design
- Document complex business logic
