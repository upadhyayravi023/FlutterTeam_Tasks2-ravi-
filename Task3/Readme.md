

# GitHub Followers Fetcher

This Flutter project fetches and displays the followers of a given GitHub user. It utilizes the GitHub API to retrieve followers and leverages the Provider package for state management. The app also uses Shared Preferences to store the last searched username.

## Features

- Fetch followers of a GitHub user.
- Display followers in a list.
- Utilize Provider for state management.

## Packages Used

- [provider: ^6.1.2](https://pub.dev/packages/provider)
- [http: ^1.2.1](https://pub.dev/packages/http)

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An IDE like VSCode or Android Studio.

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/dev04sa/FlutterTeam_Tasks
   
    ```

2. Install the dependencies:
    ```sh
    flutter pub get
    ```

### Running the App

1. Run the app on an emulator or a physical device:
    ```sh
    flutter run
    ```

## Project Structure

- `lib/`
  - `main.dart`: The entry point of the application.
  - `models/`
    - `follower.dart`: The data model for a GitHub follower.
  - `providers/`
    - `follower_provider.dart`: The provider for managing follower data.
  - `services/`
    - `github_api_service.dart`: The service for making API calls to GitHub.
  - `screens/`
    - `home_screen.dart`: The main screen displaying the list of followers.
  - `widgets/`
    - `follower_list_item.dart`: A widget for displaying individual follower details.



## ScreenShots

![Screenshot_20240707_143702](https://github.com/dev04sa/FlutterTeam_Tasks/assets/129666293/c9d0a1d9-041e-4235-9224-d6d28b8ab434)





![Screenshot_20240707_143641](https://github.com/dev04sa/FlutterTeam_Tasks/assets/129666293/1919d93e-cf77-43a2-ad9f-7f4c744a5d46)





https://github.com/dev04sa/FlutterTeam_Tasks/assets/129666293/88d8245e-83e0-4791-8e70-ea4a8aa461a1






## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


This README provides a comprehensive guide to your Flutter project, including installation instructions, project structure, and code explanations. You can customize it further as needed.
