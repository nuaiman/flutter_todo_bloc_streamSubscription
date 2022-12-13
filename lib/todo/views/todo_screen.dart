import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/views/widgets/create_todo.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/views/widgets/filter_todo.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/views/widgets/show_todo.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/views/widgets/todo_header.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(height: 20),
                FilterTodo(),
                const ShowTodo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
