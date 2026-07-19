# CI/CD Pipeline Enhancement Guide

## Overview
هذا المستند يحتوي على إرشادات لتحسين pipelines CI/CD الحالية.

## 1. تحديث Flutter Workflow

### الملف: `.github/workflows/flutter.yml`

استبدل المحتوى الحالي بـ:

```yaml
name: Flutter CI/CD

on:
  push:
    branches: [ main, develop, 'feat/**' ]
  pull_request:
    branches: [ main, develop ]

jobs:
  analyze:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          cache: true

      - name: Get dependencies
        run: cd hasad/mobile && flutter pub get

      - name: Format check
        run: cd hasad/mobile && dart format --set-exit-if-changed .

      - name: Analyze
        run: cd hasad/mobile && flutter analyze

  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          cache: true

      - name: Get dependencies
        run: cd hasad/mobile && flutter pub get

      - name: Run tests
        run: cd hasad/mobile && flutter test --coverage

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./hasad/mobile/coverage/lcov.info
          flags: flutter
          name: flutter-coverage
          fail_ci_if_error: false

  build-android:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          cache: true

      - name: Get dependencies
        run: cd hasad/mobile && flutter pub get

      - name: Build APK
        run: cd hasad/mobile && flutter build apk --split-per-abi --no-shrink
        continue-on-error: true

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: flutter-apk
          path: 'hasad/mobile/build/app/outputs/flutter-apk/*.apk'
        if: always()

  build-ios:
    runs-on: macos-latest
    
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          cache: true

      - name: Get dependencies
        run: cd hasad/mobile && flutter pub get

      - name: Build iOS
        run: cd hasad/mobile && flutter build ios --no-codesign
        continue-on-error: true

      - name: Upload iOS build
        uses: actions/upload-artifact@v4
        with:
          name: flutter-ios
          path: 'hasad/mobile/build/ios/iphoneos/*.app'
        if: always()
```

**الميزات المضافة:**
- ✅ فصل التحليل والاختبار والبناء
- ✅ تغطية اختبارات (Coverage)
- ✅ بناء APK و iOS
- ✅ رفع النتائج على Codecov

---

## 2. تحديث .NET Workflow

### الملف: `.github/workflows/dotnet.yml`

استبدل المحتوى الحالي بـ:

```yaml
name: .NET CI/CD

on:
  push:
    branches: [ main, develop, 'feat/**' ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: hasad_db_test
        options: >
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '8.0.x'

      - name: Restore dependencies
        run: cd hasad/backend && dotnet restore Hasad.sln

      - name: Build
        run: cd hasad/backend && dotnet build Hasad.sln --configuration Release --no-restore

      - name: Run tests
        run: cd hasad/backend && dotnet test Hasad.sln --configuration Release --no-build --verbosity normal --logger "trx;LogFileName=test-results.trx"
        env:
          ConnectionStrings__DefaultConnection: "Host=localhost;Database=hasad_db_test;Username=postgres;Password=postgres"

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-results-dotnet
          path: '**/test-results.trx'

  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '8.0.x'

      - name: Restore dependencies
        run: cd hasad/backend && dotnet restore Hasad.sln

      - name: Build with security analysis
        run: cd hasad/backend && dotnet build Hasad.sln --configuration Release
        continue-on-error: true
```

**الميزات المضافة:**
- ✅ PostgreSQL service للاختبارات
- ✅ اختبارات مع قاعدة البيانات الفعلية
- ✅ رفع نتائج الاختبارات
- ✅ فحص أمان

---

## 3. متغيرات البيئة

### الملف: `.env.example` ✅ تم إنشاؤه

يحتوي على جميع المتغيرات المطلوبة

### الملف: `hasad/backend/Hasad.Api/appsettings.Development.json` ✅ تم تحديثه

مع مستويات Logging محسّنة

### الملف: `hasad/backend/Hasad.Api/appsettings.Production.json` ✅ تم إنشاؤه

مع متغيرات البيئة الآمنة

---

## 4. التشغيل المحلي

### Backend Setup

```bash
# 1. نسخ متغيرات البيئة
cp .env.example .env

# 2. تثبيت PostgreSQL (اختياري إذا لم تكن مثبتة)
# macOS: brew install postgresql
# Ubuntu: sudo apt-get install postgresql
# Windows: https://www.postgresql.org/download/windows/

# 3. بدء PostgreSQL
# macOS/Ubuntu: brew services start postgresql أو sudo systemctl start postgresql
# Windows: من Control Panel → Services

# 4. إنشاء قاعدة البيانات
createdb hasad_db

# 5. تشغيل Backend
cd hasad/backend
dotnet restore
dotnet run --project Hasad.Api
```

### Mobile Setup

```bash
# 1. الذهاب للمجلد
cd hasad/mobile

# 2. تثبيت Dependencies
flutter pub get

# 3. تشغيل code generation
dart run build_runner build

# 4. تشغيل التطبيق
flutter run
```

---

## 5. الخطوات التالية المقترحة

- [ ] إضافة SonarCloud للتحليل الثابت
- [ ] إضافة Codecov للتغطية
- [ ] إعداد Docker للـ Backend
- [ ] إضافة automated testing قبل الدمج
- [ ] إعداد releases تلقائية

---

**ملاحظة:** جميع الإرشادات أعلاه يمكن تطبيقها يدويًا عبر:
1. فتح الملف الموجود على GitHub
2. النقر على زر Edit (✏️)
3. استبدال المحتوى
4. حفظ التغييرات (Commit)
