import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_bloc_barrel.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/models/todo_model.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoFilteredListBloc>().state.todos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return todoListTile(context, todos[index]);
      },
    );
  }

  Widget todoListTile(BuildContext context, TodoModel todo) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<TodoListBloc>().add(DeleteTodoListEvent(todoId: todo.id));
      },
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) {
            context
                .read<TodoListBloc>()
                .add(ToggleodoListEvent(todoId: todo.id));
          },
        ),
        title: Text(todo.desc),
      ),
    );
  }
}
