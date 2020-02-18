import 'package:flutter/material.dart';
import 'package:state_bloc/state_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          child: Counter(),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  StateBloc<int> stateBloc = StateBloc<int>(0);

  void initState() {
    stateBloc.listenToValue(listenToValue: (int value) {
      //listen to the value when changed
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: BlocBuilder<int>(
                    stateBloc: stateBloc,
                    widget: (int value) {
                      return Text("$value");
                    },
                  ),
                )),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => stateBloc.changeState(state: (int value) {
                ++value;
                return value;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
