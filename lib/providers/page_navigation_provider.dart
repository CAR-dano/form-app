import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';

class PageNavigationController extends StateNotifier<PageController> {
  final Ref _ref;

  PageNavigationController(this._ref) : super(PageController(initialPage: _ref.read(formStepProvider))) {
    _ref.listen<int>(formStepProvider, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.hasClients && state.page?.round() != next) {
          state.animateToPage(
            next,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  void goToNextPage() {
    if (state.page != null) {
      final currentPage = state.page!.round();
      _ref.read(formStepProvider.notifier).state = currentPage + 1;
    }
  }

  void goToPreviousPage() {
    if (state.page != null && state.page! > 0) {
      final currentPage = state.page!.round();
      _ref.read(formStepProvider.notifier).state = currentPage - 1;
    }
  }

  void jumpToPage(int page) {
    if (state.hasClients) {
      state.jumpToPage(page);
    }
    _ref.read(formStepProvider.notifier).state = page;
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final pageNavigationProvider = StateNotifierProvider<PageNavigationController, PageController>((ref) {
  return PageNavigationController(ref);
});
