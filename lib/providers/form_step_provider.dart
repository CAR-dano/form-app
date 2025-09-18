import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage the current step of the multi-step form  
final formStepProvider = NotifierProvider<FormStepNotifier, int>(() {
  return FormStepNotifier();
});

class FormStepNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void reset() {
    state = 0;
  }

  void setStep(int step) {
    state = step;
  }
}
