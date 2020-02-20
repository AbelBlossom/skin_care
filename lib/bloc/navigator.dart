import 'package:flutter/material.dart';

class NavigatorBloc {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future push(String route) async {
    await navigatorKey.currentState.pushNamed(route);
  }

  void pop() {
    navigatorKey.currentState.pop();
  }
}
