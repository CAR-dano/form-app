import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/custom_message_overlay.dart';
import 'package:form_app/utils/crashlytics_util.dart';

final customMessageOverlayProvider = Provider((ref) {
  return CustomMessageOverlay(ref.read(crashlyticsUtilProvider));
});
