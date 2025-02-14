# Characters

## Requirements:
### Functional:
- Fetching and parsing data from [Rick and Morty API](https://rickandmortyapi.com/documentation/).
- Display a list of loaded characters, with pagination (load 20 characters at a
time).
- Implement filtering functionality to allow users to filter the list by character
status (alive, dead, unknown).
- Navigation to Details view.
- Provide a detailed view of a selected character.

### Non-Functional:
- Performance:
  - Caching API and Images.

- Scalability:
  - Modularity.
  
- Reliability:
  - Unit tests.

- Dependency Manager:
  - No external dependencies used.
  
## System Design
- Language:
  - Swift 5
- UI:
  - SwiftUI
- Principals and Patterns:
  - MVVM Architecture
  - SOLID Principles:
    - Single Responsibility
    - Interface Segregation
    - Dependency Inversion 
  - Applying dependency injection.
  - Coordinator pattern for navigation.

