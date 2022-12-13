import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_active_count/todo_active_count_bloc.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Todos',
          style: TextStyle(fontSize: 40),
        ),
        Text(
          '${context.watch<TodoActiveCountBloc>().state.activeCount} items left',
          style: const TextStyle(fontSize: 20, color: Colors.red),
        ),
      ],
    );
  }
}
