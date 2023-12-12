import 'package:json_annotation/json_annotation.dart';

part 'json_serialization/cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final String id;
  final double durration;
  final String title;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.durration,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
