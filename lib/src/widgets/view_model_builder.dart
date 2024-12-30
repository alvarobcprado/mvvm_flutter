// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/src/utils/typedefs.dart';
import 'package:mvvm_flutter/src/view_model/view_model.dart';

class ViewModelBuilder extends StatelessWidget {
  const ViewModelBuilder({
    super.key,
    required this.builder,
    required this.viewModel,
  });

  final WidgetBuilder builder;
  final ViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => builder(context),
    );
  }
}

class StatefulViewModelBuilder<S> extends StatelessWidget {
  const StatefulViewModelBuilder({
    super.key,
    required this.builder,
    required this.viewModel,
  });

  final StatefulViewModelWidgetBuilder<S> builder;
  final StatefulViewModel<S> viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => builder(context, viewModel.state),
    );
  }
}
