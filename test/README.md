# Test Suite

This directory contains tests for the Car-dano Palapa Form App.

## Test Structure

```
test/
├── models/
│   └── api_exception_test.dart      # Tests for ApiException model
├── services/
│   ├── auth_service_test.dart       # Tests for AuthService
│   └── inspection_service_test.dart # Tests for InspectionService
└── widget_test.dart                  # Widget/UI tests
```

## Running Tests

### Run all tests
```bash
flutter test
```

### Run specific test file
```bash
flutter test test/models/api_exception_test.dart
flutter test test/services/auth_service_test.dart
flutter test test/services/inspection_service_test.dart
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Run tests in watch mode (requires package)
```bash
flutter test --watch
```

## Test Categories

### Unit Tests
- **api_exception_test.dart**: Tests the ApiException model
  - Constructor validation
  - Named parameter usage
  - toString() formatting
  - Real-world scenarios

### Service Tests
- **auth_service_test.dart**: Tests authentication service
  - Token management
  - Login/logout flows
  - Error handling architecture
  - Crashlytics integration

- **inspection_service_test.dart**: Tests inspection service
  - API call patterns
  - Error handling consistency
  - Cancellation handling
  - Crashlytics logging

## Error Handling Architecture Tests

The test suite validates the following error handling patterns:

### Service Layer Pattern
```dart
try {
  // API call
  if (badResponse) throw ApiException(message: ...);
} on ApiException catch (e, stackTrace) {
  if (!isCancelled) _crashlytics.recordError(e, stackTrace, reason: ...);
  rethrow;
} catch (e, stackTrace) {
  if (!isCancelled) _crashlytics.recordError(e, stackTrace, reason: ...);
  throw ApiException(message: ...);
}
```

### UI Layer Pattern
```dart
try {
  await service.method();
} on ApiException catch (e) {
  // NO Crashlytics - service already logged
  showMessage(e.message);
}
```

## Key Test Principles

1. **Consistency**: All services follow the same error handling pattern
2. **Crashlytics**: Service layer logs all errors, UI layer doesn't
3. **Cancellation**: User cancellations are not logged as errors
4. **ApiException**: All service errors are converted to ApiException
5. **Named Parameters**: ApiException uses named parameters for clarity

## Dependencies

- `flutter_test`: Flutter's testing framework
- `mocktail`: Modern mocking library for Dart

## Before Running Tests

Make sure you have installed dependencies:
```bash
flutter pub get
```

## Test Coverage Goals

- Models: 100% coverage
- Services: >80% coverage (excluding integration tests)
- Widgets: >70% coverage

## Notes

Some tests are documented as "integration tests would verify" - these are placeholders for tests that require actual HTTP calls and would be better suited for integration testing rather than unit testing.

## CI/CD Integration

These tests are designed to run in CI/CD pipelines. They:
- Don't require external services
- Use mocks for dependencies
- Run quickly (<5 seconds total)
- Have no flaky tests

## Troubleshooting

### "No such file or directory" errors
Make sure you run tests from the project root:
```bash
cd /path/to/form-app
flutter test
```

### Mock-related errors
Ensure mocktail is installed:
```bash
flutter pub get
```

### Firebase-related errors in tests
Tests mock Crashlytics, so Firebase doesn't need to be initialized for tests to pass.
