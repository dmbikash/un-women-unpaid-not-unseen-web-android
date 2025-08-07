import 'package:flutter/material.dart';

/// Custom page transition that has no animation
class NoAnimationTransitionBuilder extends PageTransitionsBuilder {
  const NoAnimationTransitionBuilder();

  @override
  Widget buildTransitions<T>(PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,) {
    // Return the child directly without any transition animation
    return child;
  }
}