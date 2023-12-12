import 'package:json_annotation/json_annotation.dart';

part 'json_serialization/address.g.dart';

@JsonSerializable()
class Address {
  String street;
  String number;
  String city;
  String postcode;

  Address(
      {required this.street,
      required this.number,
      required this.city,
      required this.postcode});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
