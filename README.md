# Spotify Clone App with Flutter

Welcome to the Spotify Clone App project! This project demonstrates how to build a Spotify-like music streaming app using Flutter. It incorporates Clean Architecture, Bloc for state management, Firebase for backend services, and Figma for UI design.

Figma -> https://www.figma.com/design/nhC6EZAe0AL8e1dUqsEFTL/Spotify-Clone

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)

## Features

- Clean Architecture implementation
- State management using Bloc (Cubit)
- Firebase integration for Firestore storage and authentication
- Light and dark theme support
- User authentication (sign up and sign in)
- Music playback using just Audio
- User profile and favorite songs management

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following installed on your machine:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A code editor (e.g., [VS Code](https://code.visualstudio.com/))

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/alvaral/spotify_clone_flutter.git
    cd spotify_clone_flutter
    ```

2. Install the required dependencies:

    ```bash
    flutter pub get
    ```

3. Set up Firebase:

    - Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/).
    - Add your Android and iOS apps to the Firebase project.
    - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate directories:
      - `android/app` for `google-services.json`
      - `ios/Runner` for `GoogleService-Info.plist`
    - Enable Email/Password authentication in the Firebase Console.
    - Set up Firestore database rules to allow read and write access.

4. Run the app:

    ```bash
    flutter run
    ```

## Usage

- **Sign Up/Sign In**: Register a new account or sign in with an existing account.
- **Light/Dark Theme**: Switch between light and dark themes.
- **Music Playback**: Browse and play music tracks.
- **Favorites**: Add or remove songs from your favorites.
- **User Profile**: View and edit user profile information.

## Project Structure

```
lib
│───bloc                   # Bloc (Cubit) state management
│───data                   # Data layer (models, repositories)
│───domain                 # Domain layer (use cases, entities)
│───presentation           # UI layer (screens, widgets)
│───services               # Firebase and other services
│───main.dart              # Entry point of the application
assets
│───images                 # Image assets
```

## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile from a single codebase.
- **Bloc (Cubit)**: State management library for managing app state.
- **Firebase**: Backend-as-a-Service for authentication, Firestore, and storage.
- **Figma**: UI/UX design tool for designing the app interface.
- **Just Audio**: Audio playback package for Flutter.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature-name`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to customize this README file according to your project's specific needs. If you have any questions or need further assistance, please contact us at [your-email@example.com]. Happy coding!