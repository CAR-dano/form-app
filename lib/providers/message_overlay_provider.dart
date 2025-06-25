import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/custom_message_overlay.dart';

final customMessageOverlayProvider = Provider((ref) {
  return CustomMessageOverlay();
});
