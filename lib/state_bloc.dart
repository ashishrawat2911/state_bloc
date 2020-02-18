library state_bloc;

import 'dart:async';

import 'package:flutter/material.dart';

/*
  This callback requires a widget to return and needs a value T 
*/
typedef OnWidgetStateChanged<T> = Widget Function(T value);
typedef ChangeState<T> = T Function(T value);
typedef ListenToState<T> = void Function(T value);

/*
 Define a [StateBloc]
 Example :
 StateBloc<int> stateBloc=StateBloc<int>(0);
*/

class StateBloc<T> {
  T _value;
  StreamController<T> controller;

  StateBloc(T initialData, {bool isBroadcasting = true}) {
    this._value = initialData;
    controller = isBroadcasting
        ? StreamController<T>.broadcast()
        : StreamController<T>();
  }

  /*
   stateBloc.changeState(state: (value) {
        //do somthing with value
        return value;
      });
  });
  */

  changeState({@required ChangeState<T> state}) {
    _value = state(_value);
    controller.sink.add(_value);
  }

  /*
  stateBloc.changeStateWithoutValueProvided(value);
  */

  changeStateWithoutValueProvided(T value) {
    _value = value;
//    print(_value);
    controller.sink.add(_value);
  }

  //This will return a current value that is stored in this class
  T get value => _value;

  /*
  This requires to return a widget , whenever there is any change in the value of the bloc this method will update the state of the widget with new value
  stateBloc.blocWidget(widget: (value) {
  return Text("$value");
  });
  */

  Widget blocWidget({@required OnWidgetStateChanged<T> widget}) {
    return StreamBuilder<T>(
      initialData: _value,
      stream: controller.stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        return widget(snapshot.data);
      },
    );
  }

  listenToValue({@required ListenToState<T> listenToValue}) {
    controller.stream.listen((T data) {
      listenToValue(data);
    });
  }

  void dispose() {
    controller.close();
  }
}

class BlocStreamBuilder<T> extends StatelessWidget {
  final OnWidgetStateChanged<T> widget;
  final StateBloc<T> stateBloc;

  BlocStreamBuilder({@required this.widget, @required this.stateBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: stateBloc.value,
      stream: stateBloc.controller.stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        return widget(snapshot.data);
      },
    );
  }
}

/*
* BlocBuilder will be used when you dont want to wrap any widget that contains the streambuilder
* */

@immutable
// ignore: must_be_immutable
class BlocBuilder<T> extends StatelessWidget {
  final StateBloc<T> stateBloc;

  final OnWidgetStateChanged<T> widget;

  BlocBuilder({
    @required this.stateBloc,
    @required this.widget,
  });

  T value;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
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
        return widget(stateBloc.value);
      },
    );
  }
}
