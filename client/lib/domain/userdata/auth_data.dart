// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';

class AuthData {
  String email;
  String password;
  BuildContext context;
  AuthData({
    required this.email,
    required this.password,
    required this.context
  });
}
