import 'package:flutter/material.dart';
import 'package:state_bloc/src/typedefs.dart';

class StateBlocBuilderBaseView extends StatefulWidget {
  const StateBlocBuilderBaseView({
    Key key,
    @required this.builder,
    this.initState,
  })  : assert(builder != null),
        super(key: key);

  final StateBuilder builder;
  final StateBuilderInitState initState;

  @override
  _StateBlocBuilderBaseViewState createState() =>
      _StateBlocBuilderBaseViewState();
}

class _StateBlocBuilderBaseViewState extends State<StateBlocBuilderBaseView> {
  @override
  void initState() {
    widget.initState(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
