import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc_streamsubscription/todo/blocs/todo_list/todo_list_bloc.dart';

part 'todo_active_count_event.dart';
part 'todo_active_count_state.dart';

class TodoActiveCountBloc
    extends Bloc<TodoActiveCountEvent, TodoActiveCountState> {
  late final StreamSubscription countSubscription;

  final int initialActiveCount;
  final TodoListBloc todoListBloc;
  TodoActiveCountBloc(
      {required this.initialActiveCount, required this.todoListBloc})
      : super(TodoActiveCountState(activeCount: initialActiveCount)) {
    countSubscription = todoListBloc.stream.listen((TodoListState state) {
      final int currentActiveCount = todoListBloc.state.todos
          .where((element) => !element.isDone)
          .toList()
          .length;

      add(GetTodoActiveCountEvent(activeCount: currentActiveCount));
    });
    on<GetTodoActiveCountEvent>((event, emit) {
      emit(state.copyWith(activeCount: event.activeCount));
    });
  }

  @override
  Future<void> close() {
    countSubscription.cancel();
    return super.close();
  }
}
