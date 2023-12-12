// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json,String id) {
  Timestamp beginStamp = json["begin"];
  Timestamp endStamp = json["end"];
  Timestamp dateStamp = json["date"];

  return Appointment(
    id: id,
    date: dateStamp.toDate(),
    state: $enumDecode(_$AppointmentStateEnumMap, json['state']),
    begin: beginStamp.toDate(),
    end: endStamp.toDate(),
    workerId: json['workerId'] as String,
    durration: (json['durration'] as num).toDouble(),
    items: [],
    total: (json['total'] as num).toDouble(),
  );
}

//(json['items'] as List<dynamic>)
// .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
// .toList()
Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'workerId': instance.workerId,
      'state': _$AppointmentStateEnumMap[instance.state],
      'begin': instance.begin.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'durration': instance.durration,
      'items': instance.items,
      'total': instance.total,
    };

const _$AppointmentStateEnumMap = {
  AppointmentState.create: 'create',
  AppointmentState.booked: 'booked',
  AppointmentState.confirmed: 'confirmed',
  AppointmentState.block: 'block',
};
