import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';

class PageNavigationController extends StateNotifier<PageController> {
  final Ref _ref;

  PageNavigationController(this._ref) : super(PageController(initialPage: _ref.read(formStepProvider)));

  void goToNextPage() {
    if (state.hasClients) {
      state.animateToPage(
        state.page!.round() + 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
    if (state.hasClients && state.page != null && state.page! > 0) {
      state.animateToPage(
        state.page!.round() - 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  void jumpToPage(int page) {
    if (state.hasClients) {
      state.jumpToPage(page);
      // Also update the formStepProvider state directly here to ensure consistency
      // as jumpToPage doesn't trigger onPageChanged if the page is the same.
      if (_ref.read(formStepProvider) != page) {
        _ref.read(formStepProvider.notifier).state = page;
      }
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final pageNavigationProvider = StateNotifierProvider.autoDispose<PageNavigationController, PageController>((ref) {
  return PageNavigationController(ref);
});
