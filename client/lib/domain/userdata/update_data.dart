// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdataData extends Equatable {
  final String id;
  final String title;
  final String details;
  final String category;
  UpdataData({
    required this.id,
    required this.title,
    required this.details,
    required this.category
  });

  @override
  List<Object> get props => [id, title, details,category];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'details': details,
      'category': category,
    };
  }

  factory UpdataData.fromMap(Map<String, dynamic> map) {
    return UpdataData(
      id: map['id'] as String,
      title: map['title'] as String,
      details: map['details'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdataData.fromJson(String source) => UpdataData.fromMap(json.decode(source) as Map<String, dynamic>);
}
