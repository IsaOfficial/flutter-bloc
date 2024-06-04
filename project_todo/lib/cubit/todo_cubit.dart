import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    if (title.isEmpty) {
      addError('Title cannot be empty');
      return;
    }
    final todo = Todo(
      name: title,
      createdAt: DateTime.now(),
    );

    emit([...state, todo]);
  }

  void editTodo(int index, String newTitle) {
    if (newTitle.isEmpty) {
      addError('Title cannot be empty');
      return;
    }
    final updatedTodos = List<Todo>.from(state);
    updatedTodos[index] = Todo(
      name: newTitle,
      createdAt: updatedTodos[index].createdAt,
    );

    emit(updatedTodos);
  }

  void deleteTodo(int index) {
    final updatedTodos = List<Todo>.from(state)..removeAt(index);
    emit(updatedTodos);
  }

  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }
}
