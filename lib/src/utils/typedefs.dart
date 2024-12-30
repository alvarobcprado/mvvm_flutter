import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter/src/utils/utils.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);
typedef CommandAction2<T, A, B> = Future<Result<T>> Function(A, B);

typedef ViewModelWidgetBuilder = Widget Function(BuildContext context);
typedef StatefulViewModelWidgetBuilder<S> = Widget Function(
  BuildContext context,
  S state,
);

typedef CommandWidgetBuilder<T> = Widget Function(
  BuildContext context,
  CommandState<T> state,
);
