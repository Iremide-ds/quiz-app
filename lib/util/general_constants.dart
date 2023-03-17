import 'package:flutter/material.dart';

/// A mixin of app wide functions or constants.
mixin GeneralConstants {
  /// Ensure context is initialized to avoid errors.
  late BuildContext _ctx;

  /// This is the [BuildContext] that [GeneralConstants] will use.
  /// Initialize context as early as possible.
  set setContext(BuildContext context) {
    _ctx = context;
  }

  ThemeData get _theme => Theme.of(_ctx);

  double get defaultRadius => 32.0;

  /// Linear gradient for app theme
  LinearGradient get getGradient {
    return LinearGradient(
      colors: [
        _theme.colorScheme.primary,
        _theme.colorScheme.secondary,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}
