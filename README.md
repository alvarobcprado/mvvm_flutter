# MVVM Flutter

`mvvm_flutter` is a package designed to help you implement the Model-View-ViewModel (MVVM) architecture pattern in Flutter applications, leveraging the recommended architecture suggested by the Flutter team. This package provides essential tools such as `ViewModel` and `StatefulViewModel` base classes, `Command` pattern support, and error handling with `Result` classes to streamline development and enhance code maintainability.

## Features

- **ViewModel and StatefulViewModel**: Provides base classes for creating simple ViewModel or a ViewModel with `State`.
- **Command Pattern Support**: Allows you to use the Command pattern inside your ViewModels with the `Command` class.
- **Result Class**: Simplifies error handling by wrapping results in success or failure classes.
- **ViewModelBuilder and CommandBuilder**: Simplifies UI building by automatically managing updates from ViewModels and Commands.

## Installation

To use the `mvvm_flutter` package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  mvvm_flutter: ^latest_version
```

Then run:

```bash
flutter pub get
```

## Usage Example

Here is an example of how to use `mvvm_flutter` to build a simple counter app with increment and decrement functionality.

### 1. Create a ViewModel

First, create a `CounterViewModel` class that extends `StatefulViewModel` or `ViewModel` to manage the state of the counter.

```dart
import 'package:mvvm_flutter/mvvm_flutter.dart';

class CounterViewModel extends StatefulViewModel<int> {
  CounterViewModel() : super(0);

  late final increment = Command0(_complexIncrement);

  Future<Result<void>> _complexIncrement() async {
    try{
      setState(state + 1);
      await _complexAsyncMethod();
      return Result.success(null);
    } catch(e) {
      return Result.error(e);
    }
  }

  void decrement() {
    setState(state - 1);
  }

  Future<void> _complexAsyncMethod() async {}
}
```

### 2. Create the Main Application

Then, set up your `MainApp` widget which uses the `CounterViewModel` and integrates it with the UI.

```dart
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/mvvm_flutter.dart';
import 'counter_view_model.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final viewModel = CounterViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MVVM Flutter Example'),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: viewModel.increment.run,
              tooltip: 'Increment',
              child: CommandBuilder(
                command: viewModel.increment,
                builder: (context, state) {
                  return state.isRunning
                      ? CircularProgressIndicator(color: Colors.white)
                      : Icon(Icons.add);
                },
              ),
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              onPressed: viewModel.decrement,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ),
        body: Center(
          child: StatefulViewModelBuilder(
            viewModel: viewModel,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have pushed the button this many times:'),
                  Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
```

### ViewModel Classes
- **`ViewModel`**: The base class for a ViewModel, can notify changes to the view by calling `notifyView`.
- **`StatefulViewModel<T>`**: Extends `ViewModel`. Wraps a `State` and provides `setState` method for updating the state.

### Command Class
- **`Command<T>`**: Base class to create commands that execute actions in the ViewModel and can completes with a `Result<T>`.
- **`Command0<T>`**: A command that takes no arguments.
- **`Command1<T, A>`**: A command that takes one argument of type A.
- **`Command2<T, A, B>`**: A command that takes two arguments of type A and B.

### Result Class
- **`Result<T>`**: Wraps the result of an operation, allowing you to handle success (`Result.success()`) or failure (`Result.error()`).

### Builders
- **`ViewModelBuilder`**: A widget that listens to changes in the ViewModel and rebuilds the widget tree when the ViewModel changes.
- **`StatefulViewModelBuilder<S>`**: A widget that listens to changes in the ViewModel’s state and rebuilds the widget tree when the state changes.
- **`CommandBuilder<T>`**: A widget that listens to command execution states and updates the UI accordingly.
