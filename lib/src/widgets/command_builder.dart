// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/src/utils/utils.dart';

class CommandBuilder<T> extends StatelessWidget {
  const CommandBuilder({
    super.key,
    required this.command,
    required this.builder,
  });

  final Command<T> command;
  final CommandWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (context, _) => builder(
        context,
        command.state,
      ),
    );
  }
}
