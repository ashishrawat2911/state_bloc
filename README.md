# state_bloc

[![pub package](https://img.shields.io/pub/v/state_bloc.svg)](https://pub.dev/packages/state_bloc)

StateBloc help the Widget tree to rebuild again with the help of streams. You do no need to create any bloc class for managing state, just need to instantiating the **StateBloc** class with an initial value.

## Getting Started

In your flutter project add the dependency:

```yaml
state_bloc :  1.0.3
  ```
For help getting started with Flutter, view the online [documentation](https://flutter.dev).

# **Usage Example**

```
import 'package:state_bloc/state_bloc.dart';
```
### **Define a [StateBloc](https://pub.dev/packages/state_bloc)**
```dart
//Requires a initial value in it's constructor 
StateBloc<int> stateBloc = StateBloc<int>(0);
```

### **Listen to Data using StateBlocBuilder**
You will need to pass the `stateBloc` and a `widget` to StateBlocBuilder
```dart
//Define the type of data you are using in StateBloc eg : int, String, Foo.
StateBlocBuilder<int>(
  stateBloc: stateBloc,
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

## Don't forget to dispose the bloc
```dart
stateBloc.dispose();
```

## Managing App State with [get_it](https://pub.dev/packages/get_it)
get_it Package  [![pub package](https://img.shields.io/pub/v/get_it.svg)](https://pub.dev/packages/get_it) by [escamoteur](https://github.com/escamoteur)

In your flutter project add the dependency:
```yaml
get_it: <latest-version>
```
### Register the StateBloc with GetIt.
```dart
GetIt appConfig = GetIt();

void setupAppConfig() {
//This will create a Singleton for the whole app
  appConfig.registerLazySingleton(
      () => StateBloc<DarkThemeModel>(DarkThemeModel()));
}
```
if you want to register the another StateBloc with GetIt , you will have to provide the instance name.
```dart
GetIt appConfig = GetIt();

void setupAppConfig() {
  appConfig.registerLazySingleton(
      () => StateBloc<DarkThemeModel>(DarkThemeModel()), "darkMode");
}
```
### Register when the app runs.
```dart
void main() {
  setupAppConfig();
  runApp(MyApp());
}
```
### Using StateBloc instance from the GetIt
```dart
StateBloc<DarkThemeModel> stateBloc= appConfig<StateBloc<DarkThemeModel>>("darkMode");
```
Kaboom 💣💣

Now you can change the app state with StateBloc with GetIt.

