import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/todo-oparations/add_todo.dart';
import 'package:todo_app/domain/todo-oparations/get_todo.dart';
import 'package:todo_app/domain/userdata/update_data.dart';
import 'package:todo_app/infrastructure/api/api_handler.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<GetTodo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<GetTodo>> {
  var nameofcategory = "";
  TodoNotifier() : super([]);

  Future addTodo(AddTodo addTodo, WidgetRef ref) async {
    await ApiHandler().addTodo(addTodo, ref);
  }

  Future getTodo() async {
    final data = await ApiHandler().getAlltodo();
    state = data;
  }

  Future deleteTodo(String id, WidgetRef ref) async {
    await ApiHandler().deleteTodo(id, ref);
  }

  Future updateTodo(UpdataData updataData, WidgetRef ref) async {
    await ApiHandler().updateTodo(updataData, ref);
  }

  Future getCategoryData(String categoryname) async {
    nameofcategory = categoryname;
    List<GetTodo> data = [];
    final response = await ApiHandler().getAlltodo();
    for (int i = 0; i < response.length; i++) {
      if (response[i].category == categoryname.toLowerCase()) {
        data.add(response[i]);
      }
    }
    state = data;
  }
}
