# Tractian Challenge

A Flutter application for visualizing a company's asset hierarchy.

## Project Overview

This project is a Flutter application developed to visualize a company's asset hierarchy. Using a tree structure, the app displays components, assets, and locations, allowing filtering by energy sensors, vibration sensors, and critical status. This project demonstrates the ability to manage and display complex data efficiently and intuitively.

## Architecture

The project follows a clean and modular architecture, using Bloc (Business Logic Component) for state management. This architecture was chosen based on the following principles:

- **Separation of Concerns**: Each layer of the application has a clear responsibility, making the codebase easier to maintain and evolve.
- **Testability**: Using Bloc allows for easy creation of unit and integration tests.
- **Scalability**: The modular architecture makes it easy to add new features without significant refactoring.
- **Code Reusability**: Components and logic blocks can be reused across different parts of the application.

## How to Run the Project

### Prerequisites

- Flutter SDK (>= 3.3.0)
- Dart SDK

### Steps to Run

1. Clone the repository to your local environment:

    ```bash
    git clone https://github.com/Gdoliveira1/tractian_challenge.git
    ```

2. Navigate to the project directory:

    ```bash
    cd tractian-challenge
    ```

3. Install Flutter dependencies:

    ```bash
    flutter pub get
    ```

4. Run the application:

    ```bash
    flutter run
    ```

### Additional Configuration

- **API Base URL**: The base URL for the API is configured in `ApiService`. Ensure that the URL is correct.

## Data Structure

Data is organized in a tree hierarchy to display locations, assets, and components. Each node in the tree can contain sub-nodes representing the hierarchical structure of the assets.

## Features

- **Asset Tree Visualization**: Presents a hierarchical view of assets and components.
- **Filters**: Allows filtering assets by sensor type (energy, vibration) and critical status.
- **Search**: Allows searching for assets and locations.

## Contributing

Contributions are always welcome! If you have suggestions for improvements, bug fixes, or new features, feel free to open an issue or submit a pull request.

## Authors

- Gabriel Davi de Oliveira - [gabrieldavi95@gmail.com](mailto:gabrieldavi95@gmail.com)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

If you have any questions, feel free to contact:

- **Email**: [gabrieldavi95@gmail.com](mailto:gabrieldavi95@gmail.com)
- **LinkedIn**: [Gabriel Davi](https://www.linkedin.com/in/gabriel-davi/)
