


class Getcategory {
  List<String>? category;

  Getcategory({this.category});

  Getcategory.fromJson(Map<String, dynamic> json) {
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}