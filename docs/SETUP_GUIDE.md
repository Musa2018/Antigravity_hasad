# Setup Guide - HASAD

## Prerequisites

### Backend Requirements
- **Runtime**: .NET 8 SDK
- **Database**: PostgreSQL 12+
- **Tools**: Visual Studio Code or Visual Studio

### Mobile Requirements
- **Flutter**: 3.11.0 or higher
- **Dart**: 3.11.0 (bundled with Flutter)
- **iOS**: Xcode 14+ (for macOS/iOS development)
- **Android**: Android Studio or just Android SDK

---

## Backend Setup

### 1. Install Dependencies

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install dotnet-sdk-8.0 postgresql postgresql-contrib

# macOS
brew install dotnet postgresql

# Windows
# Download from: https://www.microsoft.com/net/download
# and https://www.postgresql.org/download/windows/
```

### 2. Configure Database

```bash
# Start PostgreSQL service
sudo systemctl start postgresql  # Linux
# OR
brew services start postgresql  # macOS
# OR from Services on Windows

# Create development database
createdb hasad_db
createdb hasad_db_test  # for testing

# Create user (optional)
createuser hasad_user
```

### 3. Setup Environment Variables

```bash
# Copy example file
cp .env.example .env

# Edit .env with your values
nano .env  # or your preferred editor

# Required variables (ASP.NET Core double-underscore syntax):
# ConnectionStrings__DefaultConnection=Host=localhost;Port=5432;Database=hasad_db;Username=postgres;Password=your_password
# JwtSettings__Key=<generate with: openssl rand -base64 48>
```

Alternatively, for local development you can keep the JWT key out of any file
using user secrets:

```bash
cd hasad/backend/Hasad.Api
dotnet user-secrets set "JwtSettings:Key" "$(openssl rand -base64 48)"
```

The application fails fast at startup if `JwtSettings:Key` is missing or
shorter than 32 characters. The signing key is never committed to the
repository.

To create an initial administrator account, set both `SeedAdmin__Email` and
`SeedAdmin__Password` (the password must satisfy the policy: at least 12
characters with uppercase, lowercase, digit, and symbol). If they are not set,
no admin account is seeded.

### 4. Restore and Run Backend

```bash
cd hasad/backend

# Restore NuGet packages
dotnet restore

# Run migrations (if any)
dotnet ef database update --project Hasad.Infrastructure --startup-project Hasad.Api

# Run the application
dotnet run --project Hasad.Api

# The API will be available at: https://localhost:5001
# Swagger UI: https://localhost:5001/swagger
```

### 5. Running Tests

```bash
cd hasad/backend

# Run all tests
dotnet test

# Run with coverage
dotnet test /p:CollectCoverage=true

# Run specific project tests
dotnet test Hasad.Tests --verbosity normal
```

---

## Mobile Setup

### 1. Install Flutter

```bash
# macOS
brew install flutter

# Linux (Manual)
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$PWD/flutter/bin"

# Windows
# Download from: https://flutter.dev/docs/get-started/install/windows

# Verify installation
flutter doctor
```

### 2. Get Flutter Dependencies

```bash
cd hasad/mobile

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build

# Optional: Analyze the code
flutter analyze
```

### 3. Run on Emulator/Device

```bash
# List available devices
flutter devices

# Run on default device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run on Android emulator
flutter run

# Run on iOS simulator (macOS only)
open -a Simulator
flutter run
```

### 4. Run Tests

```bash
cd hasad/mobile

# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# View coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
# or
xdg-open coverage/html/index.html  # Linux
```

### 5. Build for Release

```bash
cd hasad/mobile

# Android APK
flutter build apk --split-per-abi

# iOS (macOS only)
flutter build ios

# Web
flutter build web
```

---

## Docker Setup (Optional)

### Backend with Docker

```bash
# Build image
docker build -t hasad-api hasad/backend

# Run with PostgreSQL
docker run -e DB_HOST=db -e DB_PASSWORD=postgres \
  --link postgres:db -p 5001:80 hasad-api
```

---

## Troubleshooting

### Backend Issues

**Issue**: JWT signing key is missing or shorter than 32 characters
```
Solution: Set the JwtSettings__Key environment variable (or use
`dotnet user-secrets set "JwtSettings:Key" ...`). Never store the key in
appsettings files.
```

**Issue**: Database connection failed
```
Solution: Verify PostgreSQL is running and credentials are correct
```

**Issue**: Port 5001 already in use
```bash
# Kill the process
lsof -ti:5001 | xargs kill -9  # macOS/Linux
netstat -ano | findstr :5001   # Windows
```

### Mobile Issues

**Issue**: Flutter doctor shows issues
```bash
flutter doctor --verbose
flutter doctor -v  # More details

# Install missing components as suggested
```

**Issue**: Build cache issues
```bash
flutter clean
flutter pub get
dart run build_runner build
```

**Issue**: Emulator not detected
```bash
# Start emulator manually
emulator -list-avds
emulator -avd <avd_name>
```

---

## Development Workflow

### Backend Development

1. Create a feature branch
2. Make changes
3. Run tests locally: `dotnet test`
4. Push changes and create PR
5. GitHub Actions will run tests automatically

### Mobile Development

1. Create a feature branch
2. Make changes
3. Format code: `dart format .`
4. Analyze: `flutter analyze`
5. Run tests: `flutter test`
6. Push and create PR

---

## Additional Resources

- [.NET Documentation](https://docs.microsoft.com/dotnet)
- [Flutter Documentation](https://flutter.dev/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs)
- [HASAD Architecture](ARCHITECTURE.md)
- [Authentication Documentation](../AUTH_DOCS.md)
