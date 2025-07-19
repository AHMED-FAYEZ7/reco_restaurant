# CI/CD Setup for Reco Restaurant App

## Overview
CI/CD has been set up using GitHub Actions to ensure code quality and automatic app building.

## Required Files
- `.github/workflows/ci_cd.yml` - CI/CD configuration file

## What CI/CD Does

### 1. Code Testing (Test Job)
- **When it runs**: On every push or pull request
- **What it does**:
  - Install Flutter
  - Install dependencies
  - Check code formatting
  - Analyze code
  - Run tests
  - Build test APK
  - Build test iOS

### 2. Android Build (Build Android Job)
- **When it runs**: Only on push to main branch
- **What it does**:
  - Build production APK
  - Build App Bundle (.aab)
  - Upload files as artifacts

### 3. iOS Build (Build iOS Job)
- **When it runs**: Only on push to main branch
- **What it does**:
  - Build iOS app
  - Upload files as artifacts

## How to Use

### 1. Push Code
```bash
git add .
git commit -m "Your commit message"
git push origin main
```

### 2. Monitor CI/CD
- Go to GitHub repository
- Click on "Actions" tab
- You'll find workflow running automatically

### 3. Download Built Files
- After process completion
- Go to "Actions" tab
- Select latest workflow
- Click on "Artifacts"
- Download required files

## Additional Settings

### Adding Firebase
If you want to deploy to Firebase App Distribution:

```yaml
- name: Deploy to Firebase App Distribution
  uses: wzieba/Firebase-Distribution-Github-Action@v1
  with:
    appId: ${{ secrets.FIREBASE_APP_ID }}
    token: ${{ secrets.FIREBASE_TOKEN }}
    groups: testers
    file: build/app/outputs/flutter-apk/app-release.apk
```

### Adding Notifications
To send notifications on success or failure:

```yaml
- name: Notify on Success
  if: success()
  run: |
    echo "Build successful!"
    # Add notification code here

- name: Notify on Failure
  if: failure()
  run: |
    echo "Build failed!"
    # Add notification code here
```

## Troubleshooting

### Common Issues:
1. **Test failures**: Make sure all tests work locally
2. **Analysis failures**: Fix all warnings and errors
3. **Build failures**: Ensure all dependencies are specified in pubspec.yaml

### Useful Commands for Local Testing:
```bash
# Check formatting
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Build APK
flutter build apk --release
```

## Important Notes
- Make sure repository contains all required files
- Don't forget to add configuration files like `google-services.json` if using Firebase
- You can modify CI/CD settings according to your project needs 