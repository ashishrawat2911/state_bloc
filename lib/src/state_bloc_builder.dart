/*
* BlocBuilder will be used when you dont want to wrap any widget that contains the streambuilder
* */

import 'package:flutter/material.dart';
import 'package:state_bloc/src/state_bloc.dart';
import 'package:state_bloc/src/state_bloc_builder_base_view.dart';
import 'package:state_bloc/state_bloc.dart';

@immutable
// ignore: must_be_immutable
class StateBlocBuilder<T> extends StatelessWidget {
  final StateBloc<T> stateBloc;

  final OnWidgetStateChanged<T> widget;

  StateBlocBuilder({
    @required this.stateBloc,
    @required this.widget,
  })  : assert(stateBloc != null),
        assert(widget != null);

  T value;

  @override
  Widget build(BuildContext context) {
    return StateBlocBuilderBaseView(
      initState: (setState) {
        if (value == null) {
          setState(() {
            value = stateBloc.value;
          });
        }
        stateBloc.listenToValue(listenToValue: (value) {
          setState(() {
            this.value = value;
          });
        });
      },
      builder: (context, setState) {
        return widget(stateBloc.value);
      },
    );
  }
}
