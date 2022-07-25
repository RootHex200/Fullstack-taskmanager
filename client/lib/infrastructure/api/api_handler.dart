import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/application/todoprovider/category_provider.dart';
import 'package:todo_app/application/todoprovider/todo_provider.dart';
import 'package:todo_app/domain/auth/login_mode.dart';
import 'package:todo_app/domain/auth/registration_model.dart';
import 'package:todo_app/domain/todo-oparations/add_todo.dart';
import 'package:todo_app/domain/todo-oparations/get_categroy.dart';
import 'package:todo_app/domain/todo-oparations/get_todo.dart';
import 'package:todo_app/domain/todo_repo.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:todo_app/domain/userdata/auth_data.dart';
import 'package:todo_app/domain/userdata/update_data.dart';

//sabiturrahman60@gmail.com 123456
class ApiHandler extends Todo_repo {
  final baseurl = "http://192.168.1.7:4000/user";
  @override
  Future singin(AuthData authData) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    final datas = {"email": authData.email, "password": authData.password};
    await Dio()
        .post("${baseurl}/auth/signin", data: datas)
        .then((response) async {
      final data = Login_model.fromMap(response.data);
      authData.context.go("/home");

      await prefs.setString('id', data.id);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: 'User not found',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          fontSize: 20);
    });
  }

  @override
  Future singup(AuthData authData) async {
    final prefe = await SharedPreferences.getInstance();
    final datas = {"email": authData.email, "password": authData.password};
    await Dio()
        .post("${baseurl}/auth/signup", data: datas)
        .then((response) async {
      final data = Registration_model.fromMap(response.data);
      authData.context.go("/");
      await prefe.setString("id", data.id);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "User already exits",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red.withOpacity(0.4),
          fontSize: 16);
    });
  }

  Future checkuserlogin() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("id");
    return data;
  }

  @override
  Future addTodo(AddTodo addTodo, WidgetRef ref) async {
    ///create
    await Dio()
        .post("${baseurl}/create", data: addTodo.toMap())
        .then((response) async {
      Fluttertoast.showToast(msg: "Todo add successfully");
      ref.read(todoProvider.notifier).getTodo();
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Todo not added",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red.withOpacity(0.4),
          fontSize: 16);
    });

    ///
  }

  @override
  Future<List<GetTodo>> getAlltodo() async {
    final id = await checkuserlogin();
    List<GetTodo> data = [];
    final response = await Dio().get(
      "${baseurl}/gettodo/${id}",
    );
    for (int i = 0; i < response.data.length; i++) {
      var gettodo = GetTodo.fromJson(response.data[i]);
      data.add(gettodo);
    }
    return data;
  }

  @override
  Future deleteTodo(String id, WidgetRef ref) async {
    ///delete/
    await Dio().delete("${baseurl}/delete/${id}").then((value) {
      ref.read(todoProvider.notifier).getTodo();

      Fluttertoast.showToast(msg: 'Data delete successfully');
    }).catchError((e) {
      Fluttertoast.showToast(msg: 'Plz try agin');
    });
  }

  @override
  Future updateTodo(UpdataData updataData, WidgetRef ref) async {
    await Dio()
        .patch("${baseurl}/update/${updataData.id}", data: updataData.toMap())
        .then((value) {
      ref.read(todoProvider.notifier).getTodo();
      Fluttertoast.showToast(msg: 'Data is updated');
    }).catchError((e) {
      Fluttertoast.showToast(msg: "try agin");
    });
  }

  @override
  Future<List> getCategory() async {
    final id = await checkuserlogin();
    var data = [];
    await Dio().get("${baseurl}/getcategory/${id}").then((value) {
      final response = Getcategory.fromJson(value.data);
      data = response.category!;
    }).catchError((e) => print(e));

    return data;
  }

  @override
  Future addCategory(String categoryname, WidgetRef ref) async {
    final id = await checkuserlogin();
    await Dio().post("${baseurl}/addcategory/${id}",
        data: {"categoryname": categoryname}).then((value) {
      Fluttertoast.showToast(msg: 'Added new Category');
      ref.read(categoryProvider.notifier).getCategory();
    }).catchError((e) => Logger.v(e));
  }
}
