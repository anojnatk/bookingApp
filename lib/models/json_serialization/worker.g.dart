// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json,String id) => Worker(
      id: id,
      firstName: json['firstName'] as String,
      imageUrl: json['imageUrl'] as String,
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'imageUrl': instance.imageUrl,
      'services': instance.services,
    };
