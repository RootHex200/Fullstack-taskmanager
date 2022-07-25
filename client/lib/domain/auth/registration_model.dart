// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'dart:convert';

import 'package:equatable/equatable.dart';

class Registration_model extends Equatable {
  final String id;

  final String email;
  const Registration_model({
    required this.id,
    required this.email,
  });

  Registration_model copyWith({
    String? id,
    String? email,
  }) {
    return Registration_model(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
    };
  }

  factory Registration_model.fromMap(Map<String, dynamic> map) {
    return Registration_model(
      id: map['id'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Registration_model.fromJson(String source) => Registration_model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, email];
}
