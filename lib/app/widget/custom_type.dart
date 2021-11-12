import 'package:flutter/material.dart';

// Gesture delete
typedef FunctionCall = void Function(FutureCallback callback);

/// Load control
typedef OutsideWidgetBuilder = Widget Function(
    BuildContext context, Widget child);

enum TransitionType { scaleIn, fadeIn, bottomIn, dropDown, expandCenter }

/// Dialog
typedef DialogDismissCallback = Future<Null> Function(BuildContext context);
typedef DialogShowedCallback = Future<Null> Function(
    DialogDismissCallback dismissDialog);
typedef DialogWidgetBuilder = Widget Function(
    BuildContext context, DialogDismissCallback dismissDialog);

typedef Callback<T> = T Function();
typedef FutureCallback<T> = Future<T> Function();

typedef HMTimeCallback = void Function(String hour, String minute);
