import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_serialization/opening_time.g.dart';

@JsonSerializable()
class OpeningTime {
  DateTime begin, end;

  OpeningTime({required this.begin, required this.end});

  factory OpeningTime.fromJson(Map<String, dynamic> json) =>
      _$OpeningTimeFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningTimeToJson(this);
}
