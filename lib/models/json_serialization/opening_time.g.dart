// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../opening_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningTime _$OpeningTimeFromJson(Map<String, dynamic> json) {
  Timestamp beginStamp = json["begin"];
  Timestamp endStamp = json["end"];

  return OpeningTime(begin: beginStamp.toDate(), end: endStamp.toDate());

  // begin: DateTime.parse(json['begin'] as String),
  // end: DateTime.parse(json['end'] as String),
}

//TODO TimeStamp ausgeben
Map<String, dynamic> _$OpeningTimeToJson(OpeningTime instance) =>
    <String, dynamic>{
      'begin': instance.begin.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
