import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_item.dart';

part 'json_serialization/appointment.g.dart';

@JsonSerializable()
class Appointment {
  String id;
  DateTime date;
  String workerId;
  AppointmentState state;
  DateTime begin;
  DateTime end;
  double durration;
  List<CartItem> items;
  double total;

  String toString() {
    return "Anfang: " +
        begin.toString() +
        "Ende" +
        end.toString() +
        items.toString();
  }

  Appointment(
      {required this.id,
      required this.date,
      required this.state,
      required this.begin,
      required this.end,
      required this.workerId,
      required this.durration,
      required this.items,
      required this.total});

  factory Appointment.fromJson(Map<String, dynamic> json,String id) =>
      _$AppointmentFromJson(json,id);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

enum AppointmentState { create, booked, confirmed, block }
