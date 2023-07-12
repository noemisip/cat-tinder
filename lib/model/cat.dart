import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable(includeIfNull: false)
class Cat{

  Cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height
  });

  String? id;
  String? url;
  double? width;
  double? height;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);

}