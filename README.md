# Kopynator Flutter SDK

Official Flutter SDK for Kopynator.

## Installation

Add to your `pubspec.yaml`:
```yaml
dependencies:
  kopynator: ^1.0.0
```

Or reference directly via Git:
```yaml
dependencies:
  kopynator:
    git:
      url: https://github.com/cflorioluis/kopynator-flutter.git
```

## Usage

### 🚀 Initialize
Initialize the SDK once, typically at the entry point of your application.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final kopynator = Kopynator.initialize(
    apiKey: 'YOUR_API_KEY',
    locale: 'en',
  );
  
  // Optional: Fetch initial translations
  await kopynator.fetchTranslations();
  
  runApp(MyApp());
}
```

### 💬 Translate
```dart
Text(Kopynator.instance.t('home.title'))
```

## Publishing to Pub.dev
1. Ensure `pubspec.yaml` is correctly configured.
2. Run `flutter pub publish --dry-run`.
3. Run `flutter pub publish` to release officially.
