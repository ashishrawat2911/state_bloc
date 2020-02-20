import 'package:flutter/material.dart';

typedef OnWidgetStateChanged<T> = Widget Function(T value);

typedef ChangeState<T> = T Function(T value);

typedef ListenToState<T> = void Function(T value);

typedef StateBuilder<T> = Function(BuildContext context, StateSetter setState);

typedef StateBuilderInitState<T> = Function(StateSetter setState);
