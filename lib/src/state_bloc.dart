import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_bloc/state_bloc.dart';

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
    controller.sink.add(_value);
  }

  set value(T value) {
    _value = value;
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
