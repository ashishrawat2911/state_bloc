# state_bloc

[![pub package](https://img.shields.io/pub/v/state_bloc.svg)](https://pub.dev/packages/state_bloc)

## Getting Started

In your flutter project add the dependency:

```yaml
state_bloc :  0.0.1
  ```
For help getting started with Flutter, view the online [documentation](https://flutter.dev).

#### **Usage Example**

```
import 'package:state_bloc/state_bloc.dart';
```
### **Define a [StateBloc](https://pub.dev/packages/state_bloc)**
```
//Requires a initial value in it's constructor 
StateBloc<int> counterBloc = StateBloc<int>(0);
```

### **Listen to Data using BlocBuilder**
```dart
//Define the Generics eg : int, String, Foo.
BlocBuilder<int>(
  stateBloc: counterBloc,
  widget: (int value) {
    return Text("$value");
  },
)
```
## Change the state of the bloc
### 1. Change the state when you have no access of the value
This will provide you the previous state data present in the bloc other vise the state you have provided while instantiating the StateBloc
```dart
stateBloc.changeState(state: (value) {

  //do changes with value and return it
      return value;

});
```
### 2. Change the state without value provided
```dart
stateBloc.changeStateWithoutValueProvided(value);
```
## Listen to the value changed
```dart
stateBloc.listenToValue(listenToValue: (int value) {

  //listen to the value when changed

});
```
