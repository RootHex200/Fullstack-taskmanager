// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddTodo extends Equatable {
  final String id;
  final String title;
  final String details;
  final String category;
  const AddTodo({
    required this.id,
    required this.title,
    required this.details,
    required this.category,
  });

  AddTodo copyWith({
    String? id,
    String? title,
    String? details,
    String? category,
  }) {
    return AddTodo(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'details': details,
      'category': category,
    };
  }

  factory AddTodo.fromMap(Map<String, dynamic> map) {
    return AddTodo(
      id: map['id'] as String,
      title: map['title'] as String,
      details: map['details'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTodo.fromJson(String source) => AddTodo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title, details, category];
}
