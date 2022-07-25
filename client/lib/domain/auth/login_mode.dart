// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'dart:convert';

import 'package:equatable/equatable.dart';

class Login_model extends Equatable {
  final String id;
  final String email;
  final String token;
  
  const Login_model({
    required this.id,
    required this.email,
    required this.token,
  });



  Login_model copyWith({
    String? id,
    String? email,
    String? token,
  }) {
    return Login_model(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
    };
  }

  factory Login_model.fromMap(Map<String, dynamic> map) {
    return Login_model(
      id: map['id'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Login_model.fromJson(String source) => Login_model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, email, token];
}
