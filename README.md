# HASAD - Agricultural Damage Assessment System

## فلسطين - نظام حصاد لتوثيق الأضرار الزراعية

Comprehensive solution for documenting and assessing agricultural damage in Palestine. Built with Flutter and .NET 8.

## Getting Started

### 1. Backend Setup (.NET 8)
1.  Navigate to the backend directory:
    ```bash
    cd hasad/backend
    ```
2.  Install dependencies:
    ```bash
    dotnet restore
    ```
3.  Configure `hasad/backend/Hasad.Api/appsettings.Development.json` with a `JwtSettings:Key` (at least 32 characters) and optional `SeedAdmin` credentials.
4.  Run the API:
    ```bash
    dotnet run --project Hasad.Api
    ```
    *   API will be available at `http://localhost:5271`
    *   Swagger UI: `http://localhost:5271/swagger`

### 2. Mobile Setup (Flutter)
1.  Navigate to the mobile directory:
    ```bash
    cd hasad/mobile
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Generate required code (Drift & Freezed):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  Run the app (use `--dart-define` to specify the environment):
    ```bash
    flutter run --dart-define=APP_ENV=dev
    ```
    *   **Note for Android Emulators:** The default dev config uses `http://10.0.2.2:5271/api` to connect to the host machine.

## Documentation
- [Architecture](ARCHITECTURE.md)
- [Authentication](AUTH_DOCS.md)
- [Domain](DOMAIN_DOCS.md)
- [Security](SECURITY.md)
- [Sync](SYNC_DOCS.md)
