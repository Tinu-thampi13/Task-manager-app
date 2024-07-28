# Task Manager App

A feature-rich task management application built with Flutter, utilizing local storage, Firebase authentication, and push notifications.

## Features

- Add, edit, and delete tasks
- Local storage using SQLite (sqflite package)
- User registration and login with Firebase Authentication
- Push notifications using flutter_local_notifications
- GetX state management for efficient app-wide state control
- Sleek and intuitive user interface
- Widget testing for improved reliability

## Project Preview
<p float="left">
 <img src="https://github.com/user-attachments/assets/f3d7e930-eb58-4458-8bea-0d22ddbf6ce3" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/user-attachments/assets/63a00c57-3802-4d24-9d65-13cb018c5838" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/user-attachments/assets/8f6e1de9-90bb-49f2-a371-24e44f94c882" height= 400 width= 200 hspace="1"/>
 <img src="https://github.com/user-attachments/assets/996290d6-39e2-4792-841b-674e3a33c3ae" height= 400 width= 200 hspace="1"/>
<img src="https://github.com/user-attachments/assets/5a752383-0a66-4d5b-a258-3e18241cafd1" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/user-attachments/assets/b018b3d7-6b7c-431c-a9db-cc97b49ad60d" height= 400 width= 200 hspace="1"/>
 </p>

## Tech Stack

- Flutter
- Dart
- SQLite (sqflite)
- Firebase Authentication
- GetX
- flutter_local_notifications

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- Android Studio / VS Code
- Firebase account

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/task-manager-app.git
   ```

2. Navigate to the project directory:
   ```
   cd task-manager-app
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Set up Firebase:
   - Create a new Firebase project
   - Add your Android and iOS apps to the Firebase project
   - Download and add the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files to the respective directories

5. Run the app:
   ```
   flutter run
   ```

## Usage

1. Launch the app
2. Register a new account or log in with existing credentials
3. Add tasks using the "+" button
4. Edit tasks by tapping on them
5. Delete tasks by swiping left or right
6. Mark tasks as complete by tapping the checkbox
7. Receive push notifications for task reminders

## Testing

This project includes widget tests to ensure the reliability of the UI components. To run the tests, use the following command:

```
flutter test
```

## Push Notifications

The app uses flutter_local_notifications to send push notifications for task reminders. Notifications can be scheduled when creating or editing tasks.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [sqflite](https://pub.dev/packages/sqflite)
- [GetX](https://pub.dev/packages/get)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
