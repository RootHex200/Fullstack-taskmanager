import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/todo-oparations/add_todo.dart';
import 'package:todo_app/domain/todo-oparations/get_todo.dart';
import 'package:todo_app/domain/userdata/auth_data.dart';
import 'package:todo_app/domain/userdata/update_data.dart';

abstract class Todo_repo {
  Future singin(AuthData authData);

  Future singup(AuthData authData);

  Future checkuserlogin();

  Future addTodo(AddTodo addTodo);

  Future<List<GetTodo>> getAlltodo();

  Future deleteTodo(String id,String presentcategory, WidgetRef ref);

  Future updateTodo(UpdataData updataData, WidgetRef ref);

  Future addCategory(String categoryname,WidgetRef ref);

  Future<List> getCategory();
}
