import 'package:json_annotation/json_annotation.dart';
part 'json_serialization/service.g.dart';

@JsonSerializable()
class Service {
  String id;
  String name;
  String description;
  double price;
  double durration;

  Service(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.durration});

  @override
  String toString() {
    return id + name + description + price.toString() + durration.toString();
  }

  factory Service.fromJson(String id, Map<String, dynamic> json) =>
      _$ServiceFromJson(json,id)..id = id;

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
