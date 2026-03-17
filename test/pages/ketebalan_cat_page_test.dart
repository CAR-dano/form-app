import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/pages/ketebalan_cat_page.dart';
import 'package:form_app/providers/inspector_provider.dart';
import 'package:form_app/utils/crashlytics_util.dart';

class FakeCrashlyticsUtil implements CrashlyticsUtil {
  @override
  void recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) {}
}

void main() {
  testWidgets(
    'paint thickness fields configure next and done keyboard actions',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            crashlyticsUtilProvider.overrideWith(
              (ref) => FakeCrashlyticsUtil(),
            ),
            inspectorProvider.overrideWith(
              (ref) => Future.value(<Inspector>[]),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: KetebalanCatPage())),
        ),
      );

      await tester.pumpAndSettle();

      final List<TextField> textFields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();

      expect(textFields.first.textInputAction, TextInputAction.next);
      expect(textFields[1].textInputAction, TextInputAction.next);
      expect(textFields.last.textInputAction, TextInputAction.done);
    },
  );

  testWidgets('submitting a paint thickness field focuses the next field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          crashlyticsUtilProvider.overrideWith((ref) => FakeCrashlyticsUtil()),
          inspectorProvider.overrideWith((ref) => Future.value(<Inspector>[])),
        ],
        child: const MaterialApp(home: Scaffold(body: KetebalanCatPage())),
      ),
    );

    await tester.pumpAndSettle();

    final Finder editableFields = find.byType(EditableText);

    await tester.tap(find.byType(TextField).first);
    await tester.pump();

    expect(
      tester.widget<EditableText>(editableFields.at(0)).focusNode.hasFocus,
      isTrue,
    );

    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pump();

    expect(
      tester.widget<EditableText>(editableFields.at(1)).focusNode.hasFocus,
      isTrue,
    );
  });
}
