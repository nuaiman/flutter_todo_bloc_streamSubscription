import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_list/todo_list_bloc.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_search/todo_search_bloc.dart';

import '../../models/todo_model.dart';

part 'todo_filtered_list_event.dart';
part 'todo_filtered_list_state.dart';

class TodoFilteredListBloc
    extends Bloc<TodoFilteredListEvent, TodoFilteredListState> {
  late final StreamSubscription filterSubscription;
  late final StreamSubscription searchSubscription;
  late final StreamSubscription listSubscription;

  final List<TodoModel> initialTodoList;

  final TodoListBloc todoListBloc;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;

  TodoFilteredListBloc(
      {required this.initialTodoList,
      required this.todoListBloc,
      required this.todoSearchBloc,
      required this.todoFilterBloc})
      : super(TodoFilteredListState(todos: initialTodoList)) {
    filterSubscription =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });
    searchSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });
    listSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
    on<CalculateTodoFilteredListEvent>((event, emit) {
      emit(state.copyWith(todos: event.todos));
    });
  }

  void setFilteredTodos() {
    List<TodoModel> filteredList;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        filteredList =
            todoListBloc.state.todos.where((todo) => !todo.isDone).toList();
        break;
      case Filter.done:
        filteredList =
            todoListBloc.state.todos.where((todo) => todo.isDone).toList();
        break;
      case Filter.all:
        filteredList = todoListBloc.state.todos;
        break;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      filteredList = filteredList
          .where((todo) =>
              todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }
    add(CalculateTodoFilteredListEvent(todos: filteredList));
  }

  @override
  Future<void> close() {
    filterSubscription.cancel();
    searchSubscription.cancel();
    listSubscription.cancel();
    return super.close();
  }
}
