# AGENTS.md - Coding Agent Guidelines

## Project Overview

**Palapa Inspeksi** is a Flutter-based vehicle inspection app for PT. Inspeksi Mobil Jogja.

- **Tech Stack**: Flutter 3.10+, Riverpod 3.0, Dio, Firebase Crashlytics
- **Architecture**: Feature-driven (models, services, providers, pages, widgets, utils, formatters)
- **Target Platform**: Android (primary)
- **Environment**: WSL/Linux accessing Windows Flutter installation

## Build/Lint/Test Commands

### Installation
```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter pub get"
```

### Running the App
```bash
# Standard run
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter run"

# Debug mode with hot reload
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter run --debug"

# Release mode
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter run --release"
```

### Building APKs
```bash
# Debug build
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter build apk --debug"

# Release build (universal)
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter build apk --release"

# Release build (split per ABI - used in CI)
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter build apk --split-per-abi --release"
```

### Linting
```bash
# Analyze with fatal infos (CI standard)
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter analyze --fatal-infos"

# Standard analyze
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter analyze"
```

### Testing

**All tests:**
```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test"
```

**Single test file:**
```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test test/models/api_exception_test.dart"
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test test/services/auth_service_test.dart"
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test test/formatters/date_input_formatter_test.dart"
```

**Specific test by name:**
```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test test/models/user_data_test.dart --name 'fromJson'"
```

**With coverage:**
```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; flutter test --coverage"
```

### WSL Environment Note

This project runs in a WSL/Linux environment but uses Flutter installed on the Windows host. All Flutter commands must be executed through PowerShell using the pattern:

```bash
powershell.exe -Command "cd D:\\UGM\\Car-danoPalapa\\form-app; <flutter-command>"
```

This approach avoids:
- Path translation issues between WSL and Windows
- Line ending problems (CRLF vs LF)
- Flutter SDK not being installed in WSL

If you need to run multiple independent commands, you can run them in parallel. If commands depend on each other, chain them with `&&` within a single PowerShell command.

## Code Style Guidelines

### Imports

**Order:**
1. Dart core libraries (`dart:core`, `dart:async`, `dart:io`)
2. Flutter packages (`package:flutter/...`)
3. Third-party packages (alphabetically)
4. Relative imports (`package:form_app/...`)

**Conventions:**
- Use explicit imports (avoid unnecessary `show`, `hide`)
- Add comments to group related imports
- Prefix Dio imports: `import 'package:dio/dio.dart' as dio;`

**Example:**
```dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/auth_provider.dart';
import 'package:form_app/utils/crashlytics_util.dart';
```

### Formatting

- Run `dart format .` for consistent formatting
- **Prefer const constructors** (`prefer_const_constructors: true` in analysis_options.yaml)
- Use trailing commas for better diffs
- Default line length: 80 characters

### Types & Null Safety

- **Explicit types** for class fields and function returns
- Use `?` for nullable types
- Use `required` keyword for named parameters
- Avoid `dynamic` except for JSON parsing and intentional type flexibility
- **Don't compare with null directly**: Use nullable variables instead

**Incorrect:**
```dart
if (object == null) { ... }
```

**Correct:**
```dart
MyType? nullable;
if (object == nullable) { ... }
```

### Naming Conventions

- **Classes**: PascalCase (`FormData`, `AuthService`, `ImageDataProvider`)
- **Files**: snake_case (`auth_service.dart`, `form_provider.dart`, `api_exception.dart`)
- **Variables/Functions**: camelCase (`namaCustomer`, `loginInspector`, `fetchInspectors`)
- **Private members**: Prefix with `_` (`_dioInst`, `_baseApiUrl`, `_crashlytics`)
- **Constants**: camelCase (`maxRetries`, `defaultTimeout`)
- **Providers**: Suffix with `Provider` (`authProvider`, `formProvider`)

### Error Handling

**Two-Layer Architecture:**

#### Service Layer (auth_service.dart, inspection_service.dart)
- **Convert ALL errors to `ApiException`** with named parameters
- **Extract server response data BEFORE logging to Crashlytics** (critical for debugging)
- **Log ApiException to Crashlytics** (includes message, statusCode, and responseData)
- **Log ALL errors including cancellations** (for complete error tracking)
- **No DioException type checking** (use dynamic casting)
- Detect cancellations: check for "cancelled" or "cancel" in error message

**Pattern:**
```dart
try {
  final response = await _dioInst.post(url, data: data);
  return SomeModel.fromJson(response.data);
} on ApiException catch (e, stackTrace) {
  // Already an ApiException, log and rethrow
  _crashlytics.recordError(e, stackTrace, reason: 'Failed to perform operation');
  rethrow;
} catch (e, stackTrace) {
  // Extract server response for detailed logging
  String message = 'Operation failed';
  int? statusCode;
  dynamic responseData;
  
  // Check for cancellation
  final errorMessage = e.toString().toLowerCase();
  final isCancelled = errorMessage.contains('cancel');
  
  if (isCancelled) {
    message = 'Request cancelled';
  } else {
    // Extract response data from DioException
    try {
      final errorResponse = (e as dynamic).response;
      if (errorResponse != null) {
        statusCode = errorResponse.statusCode;
        responseData = errorResponse.data;
        
        // Extract meaningful message from server response
        if (responseData != null && responseData['message'] != null) {
          message = responseData['message'];
        } else if (responseData != null) {
          message = 'Operation failed: ${responseData.toString()}';
        }
      }
    } catch (_) {
      message = 'Operation failed: ${e.toString()}';
    }
  }
  
  // Create ApiException with server data
  final apiException = ApiException(
    message: message,
    statusCode: statusCode,
    responseData: responseData,  // This is logged to Crashlytics via toString()
  );
  
  // Log ApiException (contains server response)
  _crashlytics.recordError(
    apiException,
    stackTrace,
    reason: 'Failed to perform operation',
  );
  
  throw apiException;
}
```

**Key Points:**
1. **NEVER log raw DioException** - Always extract server response first
2. **ApiException.toString()** includes `statusCode` and `responseData` for Crashlytics
3. Server response data (e.g., `{"message": "Token expired", "code": "AUTH_ERROR"}`) is captured in `responseData`
4. Log cancellations too (for complete error tracking)

#### UI Layer (pages/)
- **Catch `ApiException`** and display error messages
- **NO Crashlytics logging** (service already logged)
- Show user-friendly messages

**Pattern:**
```dart
try {
  await ref.read(authServiceProvider).login(email, pin);
  // Navigate on success
} on ApiException catch (e) {
  // Show error to user
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(e.message)),
  );
}
```

### State Management (Riverpod 3.0)

- Use **Notifier** classes for complex state
- Use **Provider** for simple dependencies
- Access providers with `ref.watch()` (builds) or `ref.read()` (events)

**Example:**
```dart
// Provider definition
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.watch(tokenManagerProvider),
    ref,
    ref.watch(crashlyticsUtilProvider),
  );
});

// Notifier for complex state
class FormNotifier extends Notifier<FormData> {
  @override
  FormData build() {
    // Initialize and return initial state
    return FormData();
  }
  
  void updateField(String value) {
    state = state.copyWith(field: value);
  }
}

final formProvider = NotifierProvider<FormNotifier, FormData>(() {
  return FormNotifier();
});
```

## Testing Guidelines

### Test Structure

- **Use Mocktail** for mocking (`mocktail: ^1.0.4`)
- **Naming**: `*_test.dart` (e.g., `auth_service_test.dart`)
- **Organization**: Use `group()` for logical grouping, `test()` for individual tests
- **Mock Firebase/Crashlytics** to avoid initialization errors

### Test Patterns

**Model tests:**
```dart
group('ModelName', () {
  group('fromJson', () {
    test('creates instance from valid JSON', () { ... });
    test('throws when required field is missing', () { ... });
  });
  
  group('toJson', () {
    test('round-trip: fromJson().toJson() equals original', () { ... });
  });
  
  group('Real-World Scenarios', () {
    test('handles Indonesian names with special characters', () { ... });
  });
});
```

**Formatter tests (TextInputFormatter):**
```dart
// Helper function
TextEditingValue createValue(String text, [int? selectionOffset]) {
  return TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(
      offset: selectionOffset ?? text.length,
    ),
  );
}

test('formats date correctly', () {
  final formatter = DateInputFormatter();
  final oldValue = createValue('');
  final newValue = createValue('01012024');
  
  final result = formatter.formatEditUpdate(oldValue, newValue);
  
  expect(result.text, equals('01/01/2024'));
});
```

**Service tests with mocks:**
```dart
class MockDio extends Mock implements dio.Dio {}
class MockCrashlyticsUtil extends Mock implements CrashlyticsUtil {}

test('login success returns AuthResponse', () async {
  final mockDio = MockDio();
  final mockCrashlytics = MockCrashlyticsUtil();
  
  when(() => mockDio.post(any(), data: any(named: 'data')))
      .thenAnswer((_) async => dio.Response(
            data: {'accessToken': 'token', ...},
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: ''),
          ));
  
  final service = AuthService(tokenManager, ref, mockCrashlytics);
  final response = await service.loginInspector('email', 'pin');
  
  expect(response.accessToken, equals('token'));
});
```

### Real-World Context

- Use **Indonesian names** (e.g., "Budi Santoso", "Siti Nur'aini")
- Use **Indonesian city names** (e.g., "Jakarta", "Surabaya", "Yogyakarta")
- Use **car inspection scenarios** (e.g., "Ban depan aus", "Cat tergores")
- Use **Indonesian currency formatting** (e.g., "1.000.000" for 1 million)

## Architecture Notes

### Directory Structure

- `lib/models/` - Data models (serialization, equality)
- `lib/services/` - Business logic, API communication
- `lib/providers/` - Riverpod state management
- `lib/pages/` - UI screens
- `lib/widgets/` - Reusable UI components
- `lib/utils/` - Helper functions, utilities
- `lib/formatters/` - Custom TextInputFormatter classes
- `lib/statics/` - Constants, styles

### Separation of Concerns

**Service Layer:**
- Business logic
- API communication
- Error handling and logging
- Data transformation

**UI Layer:**
- Display data
- User interaction
- Show error messages
- Navigation

**Provider Layer:**
- State management
- Coordinate services
- Local persistence (JSON files)

### Local Persistence

- Form data saved as JSON in app directory
- Use `path_provider` for file paths
- Debounced saves to avoid excessive I/O

## Common Patterns

### Adding a New API Endpoint

1. Add method to service (e.g., `AuthService`)
2. Use ApiException for error handling
3. Log to Crashlytics (except cancellations)
4. Create provider if needed
5. Call from UI and catch ApiException

### Creating a New Provider

```dart
// Simple provider
final myServiceProvider = Provider<MyService>((ref) {
  return MyService(ref.watch(dependencyProvider));
});

// State provider with Notifier
class MyNotifier extends Notifier<MyState> {
  @override
  MyState build() => MyState.initial();
  
  void updateState() {
    state = state.copyWith(...);
  }
}

final myProvider = NotifierProvider<MyNotifier, MyState>(MyNotifier.new);
```

### Custom TextInputFormatter

```dart
class MyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Format logic
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
```

---

**Note**: This is a production app with real users. Test thoroughly, follow error handling patterns, and maintain consistency with existing code style.
