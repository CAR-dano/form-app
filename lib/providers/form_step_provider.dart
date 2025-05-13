import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage the current step of the multi-step form
final formStepProvider = StateProvider<int>((ref) => 0);
