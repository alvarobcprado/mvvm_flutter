import 'package:flutter/material.dart';
import 'package:mvvm_flutter/mvvm_flutter.dart';

class CalculatorViewModel extends StatefulViewModel<int> {
  CalculatorViewModel() : super(0);

  late final increment = Command0(_increment);
  late final decrement = Command0(_decrement);

  Future<Result<void>> _increment() async {
    await Future.delayed(Duration(seconds: 1));
    setState(state + 1);
    return Result.success(null);
  }

  Future<Result<void>> _decrement() async {
    await Future.delayed(Duration(seconds: 2));
    setState(state - 1);
    return Result.success(null);
  }
}

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final viewModel = CalculatorViewModel();

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
              onPressed: viewModel.decrement.run,
              tooltip: 'Decrement',
              child: CommandBuilder(
                command: viewModel.decrement,
                builder: (context, state) {
                  return state.isRunning
                      ? CircularProgressIndicator(color: Colors.white)
                      : Icon(Icons.remove);
                },
              ),
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
