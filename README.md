# ramft

A Rick and Morty Flutter project to learn TDD from

## Getting Started
The initial set up for this project is as follows:
1. Flutter - version 3.3.10
2. Dart - version 2.18.6
3. Operating System - Macos Ventura | 13.1
4. IDE/Editor - Android Studio Dolphin | 2021.3.1 Patch 1
5. Android Dependencies
   a. Android SDK - 33.0.3
   b. Kotlin - version 1.6.10
   c. Gradle - version 7.1.2
6. iOS Dependencies
   a. Xcode - version 14.2 (14C18)
   b. Swift - version 5.7.2

## Project Structure
The project is structured as follows. Some folders are not included in the structure for brevity:
- android: Contains android specific files
- assets: Contains assets for the app
- ios: Contains ios specific files
- lib
    - main.dart
    - core
        - constants: Contains app constants
        - error: Contains error widgets
        - navigation - Contains navigation routes
        - usecases: Contains base usecase for business logic
        - utils: Contains utility functions
    - features
        - feature-name
            - data
                - datasources: Contains remote data sources
                - models: Models for the data sources
                - repositories: Repository implementations
            - domain
                - entities: Contains entities
                - repositories: Contains repository contracts
                - usecases: Contains usecases for business logic
            - presentation
                - blocs: Contains blocs for state management
                - pages: Pages to be displayed
                - widgets: Widgets to be displayed
- test
  - core
      - constants: Contains app constants tests
      - error: Contains error widgets tests
      - navigation - Contains navigation routes tests
      - theme - Contains app theme tests
  - features
      - feature-name
          - data
              - datasources: Contains remote data sources tests
              - repositories: Repository implementations tests
          - domain
              - repositories: Contains repository contracts tests
              - usecases: Contains usecases for business logic tests
          - presentation
              - bloc: Contains blocs for state management tests
              - pages: Pages to be displayed tests
              - widgets: Widgets to be displayed tests
  - fixtures: Contains test fixtures
                
## Dependencies and Packages
The project uses the following dependencies and packages:
- Testing - mocktail, flutter_test
- State Management - bloc, flutter_bloc
- Navigation - auto_route
- Network - http
- Dependency Injection - get_it
- Data Persistence - shared_preferences
- Data Serialization - json_serializable
- Data Formatting - intl
- Data Parsing - html
- Data Conversion - convert

## API and Data
This project has no data caching. All data is sourced from the API. It uses the following API:
- [Rick and Morty API](https://rickandmortyapi.com/)
- [Rick and Morty API Documentation](https://rickandmortyapi.com/documentation/)
