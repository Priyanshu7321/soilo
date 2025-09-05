# 🌱 Soilo - Smart Soil Monitoring App

[![Flutter](https://img.shields.io/badge/Flutter-3.16.9-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.1.0-0175C2?logo=dart)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Soilo is a Flutter-based mobile application designed to monitor soil conditions using IoT sensors. The app provides real-time data visualization for soil temperature and moisture levels, helping users make informed decisions about their plants' care.

## ✨ Features

- 🌡️ Real-time soil temperature monitoring
- 💧 Soil moisture level tracking
- 📊 Historical data visualization
- 🔔 Customizable alerts for critical conditions
- 🔄 Offline data persistence
- 🔐 Secure user authentication

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.16.9 or higher)
- Dart SDK (3.1.0 or higher)
- Android Studio / Xcode (for emulator/simulator)
- Firebase account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/soilo.git
   cd soilo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add Android/iOS apps to your Firebase project
   - Download and add the configuration files:
     - `android/app/google-services.json` (Android)
     - `ios/Runner/GoogleService-Info.plist` (iOS)

4. **Run the app**
   ```bash
   flutter run
   ```

## 🛠️ Tech Stack

- **Frontend**: Flutter
- **State Management**: Riverpod
- **Backend**: Firebase (Authentication, Firestore, Cloud Functions)
- **Routing**: Go Router
- **Testing**: Flutter Test, Mockito

## 📱 Screenshots

| Home Screen | Sensor Data | History |
|-------------|-------------|----------|
| ![Home](screenshots/home.png) | ![Sensor](screenshots/sensor.png) | ![History](screenshots/history.png) |

## 🧪 Testing

Run tests using the following command:

```bash
flutter test
```

For integration tests:

```bash
flutter test integration_test
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- Firebase for backend services
- All contributors who helped improve this project

---

Made with ❤️ by [Your Name] | [GitHub](https://github.com/yourusername)
