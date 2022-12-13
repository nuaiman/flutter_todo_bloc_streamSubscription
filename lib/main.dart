import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_active_count/todo_active_count_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_filtered_list/todo_filtered_list_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_list/todo_list_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_search/todo_search_bloc.dart';

import 'todo/views/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ---------------------------------------------------------------------
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoActiveCountBloc>(
            create: (context) => TodoActiveCountBloc(
                  initialActiveCount:
                      context.read<TodoListBloc>().state.todos.length,
                  todoListBloc: BlocProvider.of<TodoListBloc>(context),
                )),
        // ---------------------------------------------------------------------
        BlocProvider<TodoFilteredListBloc>(
            create: (context) => TodoFilteredListBloc(
                  initialTodoList: context.read<TodoListBloc>().state.todos,
                  todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
                  todoListBloc: BlocProvider.of<TodoListBloc>(context),
                  todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
                )),
        // ---------------------------------------------------------------------
      ],
      child: MaterialApp(
        title: 'Flutter Todo Bloc StreamSubscription',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
