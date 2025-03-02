import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
