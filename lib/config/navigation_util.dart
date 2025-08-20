import 'package:flutter/material.dart';

extension NavigationExt on BuildContext {
  pushNamed(String routeName, {dynamic arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  push(MaterialPageRoute<dynamic> route) {
    return Navigator.of(this).push(route);
  }

  pop({argument}) {
    return Navigator.of(this).pop(argument);
  }

  goBack() {
    return Navigator.of(this).pop();
  }

  popTwice({argument}) {
    pop();
    return pop(argument: argument);
  }

  popUntil(String desiredRoute) {
    return Navigator.of(this).popUntil((route) {
      return route.settings.name == desiredRoute;
    });
  }

  pushNamedAndRemoveUntil(route, popToInitial) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      route,
      (route) => popToInitial,
    );
  }

  pushNamedAndRemoveUntilRouteName(route, routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      route,
          (route) => route.settings.name == routeName,
    );
  }

  pushReplacementNamed(String desiredRoute, {dynamic arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(desiredRoute, arguments: arguments);
  }
}

class NavigationUtil {
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  BuildContext getNavigationContext() {
    return navigatorKey.currentContext!;
  }
}
