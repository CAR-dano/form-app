
import 'package:flutter/widgets.dart';

class FocusNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
