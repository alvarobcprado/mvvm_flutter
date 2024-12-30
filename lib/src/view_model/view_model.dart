import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class ViewModel extends ChangeNotifier {
  ViewModel() {
    init();
  }

  void init() {}

  @internal
  @override
  void notifyListeners() => super.notifyListeners();

  void notifyView([Function? fn]) {
    if (fn != null) {
      fn();
    }
    notifyListeners();
  }
}

abstract class StatefulViewModel<State> extends ViewModel
    implements ValueListenable<State> {
  StatefulViewModel(State initialState) : _state = initialState;

  State _state;

  @internal
  @override
  State get value => _state;

  State get state => _state;

  @protected
  void setState(State newState) {
    notifyView(() => _state = newState);
  }
}
