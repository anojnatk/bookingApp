// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json,String id) => Store(
      id:id,
      name: json['name'] as String,
      branch: $enumDecode(_$BranchEnumMap, json['branch']),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      openingTimes: (json['openingTimes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, OpeningTime.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'branch': _$BranchEnumMap[instance.branch],
      'address': instance.address,
      'rating': instance.rating,
      'openingTimes': instance.openingTimes,
    };

const _$BranchEnumMap = {
  Branch.hairdresser: 'hairdresser',
};
