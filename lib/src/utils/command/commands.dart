part of 'command.dart';

/// [Command] without arguments.
/// Takes a [CommandAction0] as action.
final class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  /// Executes the action.
  Future<void> run() async {
    await _run(() => _action());
  }
}

/// [Command] with one argument.
/// Takes a [CommandAction1] as action.
final class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  /// Executes the action with the argument.
  Future<void> run(A argument) async {
    await _run(() => _action(argument));
  }
}

/// [Command] with two arguments.
final class Command2<T, A, B> extends Command<T> {
  Command2(this._action);

  final CommandAction2<T, A, B> _action;

  /// Executes the action with the arguments.
  Future<void> run(A argument1, B argument2) async {
    await _run(() => _action(argument1, argument2));
  }
}
