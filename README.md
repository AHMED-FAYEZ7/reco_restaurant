# Reco Restaurant App

A Flutter application for restaurant recommendations and food ordering.

## Features

- 🍽️ Restaurant recommendations
- 🛒 Shopping cart functionality
- 👤 User authentication
- 📱 Cross-platform (Android & iOS)
- 🔥 Firebase integration
- 🎨 Modern UI/UX

## Getting Started

### Prerequisites

- Flutter SDK (3.24.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. Clone the repository
```bash
git clone https://github.com/AHMED-FAYEZ7/reco_restaurant.git
cd reco_restaurant
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## CI/CD Setup

This project includes GitHub Actions for automated testing and building.

### Quick Start
- Push to `main` branch to trigger CI/CD
- Check `Actions` tab for build status
- Download APK from artifacts

### CI/CD Files
- `.github/workflows/simple.yml` - Basic test & build
- `.github/workflows/test.yml` - Testing only
- `.github/workflows/build.yml` - Building only
- `.github/workflows/ci_cd.yml` - Full CI/CD pipeline

For detailed CI/CD documentation, see:
- [Quick Start](QUICK_START.md) - Get started in 3 steps
- [Simple Guide](README_SIMPLE.md) - Detailed simple guide
- [Full Guide](CI_CD_README.md) - Complete documentation

## Project Structure

```
lib/
├── core/           # Core utilities, DI, routing
├── features/       # Feature modules
│   ├── auth/       # Authentication
│   ├── home/       # Home screen
│   ├── cart/       # Shopping cart
│   └── profile/    # User profile
└── main.dart       # App entry point
```

## Technologies Used

- **Flutter** - UI framework
- **Firebase** - Backend services
- **Bloc** - State management
- **Hive** - Local storage
- **Go Router** - Navigation
- **GitHub Actions** - CI/CD

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
