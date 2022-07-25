import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/presentation/addtodo/addtodo_page.dart';
import 'package:todo_app/presentation/authpage/login_page.dart';
import 'package:todo_app/presentation/authpage/registration_page.dart';
import 'package:todo_app/presentation/grouppage/gettodo_page.dart';
import 'package:todo_app/presentation/homepage/home_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return Login_page();
        }),
    GoRoute(
        path: "/addtodo",
        builder: (BuildContext context, GoRouterState state) {
          return const Addtodo_page();
        }),
    GoRoute(
        path: "/home",
        builder: (BuildContext context, GoRouterState state) {
          return const Home_page();
        }),
    GoRoute(
        path: "/registration",
        builder: (BuildContext context, GoRouterState state) {
          return const Registration_page();
        }),
    GoRoute(
        path: "/category-todo",
        builder: (BuildContext context, GoRouterState state) {
          return const Getodo_page();
        })
  ]);
}
