
part of 'command.dart';

sealed class CommandState<T> {
  const CommandState();

  bool get isIdle => this is CommandIdle;
  bool get isRunning => this is CommandRunning;
  bool get isError => this is CommandError;
  bool get isCompleted => this is CommandCompleted;
}

final class CommandIdle<T> extends CommandState<T> {
  const CommandIdle();
}

final class CommandRunning<T> extends CommandState<T> {
  const CommandRunning();
}

final class CommandError<T> extends CommandState<T> {
  const CommandError(this.error);

  final Object error;
}

final class CommandCompleted<T> extends CommandState<T> {
  const CommandCompleted(this.result);

  final Result<T> result;
}