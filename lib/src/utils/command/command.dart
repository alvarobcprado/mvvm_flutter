import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mvvm_flutter/src/utils/result.dart';
import 'package:mvvm_flutter/src/utils/typedefs.dart';

part 'command_state.dart';
part 'commands.dart';

/// Facilitates interaction with a ViewModel.
///
/// Encapsulates an action,
/// exposes its running and error states,
/// and ensures that it can't be launched again until it finishes.
///
/// Use [Command0] for actions without arguments.
/// Use [Command1] for actions with one argument.
///
/// Actions must return a [Result].
///
/// Consume the action result by listening to changes,
/// then call to [reset] when the state is consumed.
abstract class Command<T> extends ChangeNotifier {
  Command({this.onCancel});

  final VoidCallback? onCancel;

  CommandState<T> _state = const CommandIdle();

  /// True if action is running
  bool get isRunning => _state.isRunning;

  /// True if action completed with error
  bool get isError => _state.isError;

  /// True if action completed successfully
  bool get isCompleted => _state.isCompleted;

  /// Get last action state
  CommandState<T> get state => _state;

  /// Reset the action result.
  void reset() {
    _state = const CommandIdle();
    notifyListeners();
  }

  void cancel() {
    if (isRunning) {
      _state = const CommandIdle();
      onCancel?.call();
      reset();
    }
  }

  /// Internal run implementation
  Future<void> _run(CommandAction0<T> action) async {
    // Ensure the action can't launch multiple times.
    // e.g. avoid multiple taps on button
    if (isRunning) return;

    // Notify listeners.
    // e.g. button shows loading state
    _state = const CommandRunning();
    notifyListeners();

    try {
      final result = await action();
      _state = CommandCompleted(result);
    } catch (e) {
      _state = CommandError(e);
    } finally {
      notifyListeners();
    }
  }
}
