import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:form_app/main.dart';

// Import the services and models needed for overriding providers
import 'package:form_app/services/update_service.dart';
import 'package:form_app/providers/inspector_provider.dart';
import 'package:form_app/providers/inspection_branches_provider.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/models/inspection_branch.dart';

// 1. Create a "fake" notifier class for the update service.
// Updated for Riverpod 3.0 - now extends Notifier instead of StateNotifier
class FakeUpdateNotifier extends Notifier<UpdateState> implements UpdateNotifier {
  // For Riverpod 3.0, we need to implement the build method
  @override
  UpdateState build() {
    return UpdateState();
  }

  // We provide empty implementations for all public methods from the real Notifier.
  // The @override annotation is good practice here and confirms we are matching the real class.
  // The methods are marked `async` to correctly return a Future<void>.
  @override
  Future<void> checkForUpdate() async {
    // Does nothing.
  }

  @override
  Future<void> downloadUpdate() async {
    // Does nothing.
  }

  @override
  void cancelDownload() {
    // Does nothing.
  }
  
  @override
  Future<void> installUpdate() async {
    // Does nothing.
  }
}

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Use ProviderScope's `overrides` to replace real providers with fakes.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // 2. Override the update service provider to use our FakeUpdateNotifier.
          // Updated for Riverpod 3.0 - use overrideWith with a function that returns the notifier
          updateServiceProvider.overrideWith(() => FakeUpdateNotifier()),

          // 3. Override network-calling providers to return dummy data instantly.
          // This makes tests faster and more reliable.
          inspectorProvider.overrideWith(
            (ref) => Future.value([
              Inspector(id: '1', name: 'Test Inspector'),
            ]),
          ),
          inspectionBranchesProvider.overrideWith(
            (ref) => Future.value([
              InspectionBranch(id: '1', city: 'Test Branch'),
            ]),
          ),
        ],
        child: const FormApp(),
      ),
    );

    // pumpAndSettle waits for all animations and futures (like our faked ones) to complete.
    await tester.pumpAndSettle();

    // Verify that the app renders a MaterialApp without crashing.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}