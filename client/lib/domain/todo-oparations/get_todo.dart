class GetTodo {
  String? sId;
  String? id;
  String? title;
  String? details;
  String? creteAt;
  String? category;
  int? iV;

  GetTodo(
      {required this.sId,
      required this.id,
      required this.title,
      required this.details,
      required this.creteAt,
      required this.category,
      required this.iV});

  GetTodo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    details = json['details'];
    creteAt = json['creteAt'];
    category = json['category'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['creteAt'] = this.creteAt;
    data['category'] = this.category;
    data['__v'] = this.iV;
    return data;
  }
}
