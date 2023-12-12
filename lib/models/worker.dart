import 'package:customer/models/appointment.dart';
import 'package:customer/providers/cart.dart';

import 'package:json_annotation/json_annotation.dart';

part 'json_serialization/worker.g.dart';

@JsonSerializable()
class Worker {
  String id;
  String firstName;
  // List<WorkingTime> workingTimes = [];
//  bool isChoosen = false;
  List<String> services;
  //gibt an ob beim überprüfen freier termine nach freien terminen vor dem ersten element gesucht wurde
  Worker({
    required this.id,
    required this.firstName,
    required this.imageUrl,
    required this.services,
  });
  @override
  String toString() {
    return "id" + id + "firstname" + firstName;
  }

  factory Worker.fromJson(String id, Map<String, dynamic> json) =>
      _$WorkerFromJson(json,id)..id = id;

  Map<String, dynamic> toJson() => _$WorkerToJson(this);

  String imageUrl;

  //appointments nach datum sortieren
  Map<DateTime, List<Appointment>> appointments = {};

  // Map<DateTime, List<TimeSlot>> timeSlots;

  addAppointment(Appointment appointment) {
    appointments[appointment.date]!.add(appointment);
  }

  static const timeInterval = 15;

  // bool appointmentsAv = true;

  // String secondName;

  Map<DateTime, List<Appointment>> getTimeSlots() {
    return {...appointments};
  }

  List<Appointment> getAppointmentsByDate(DateTime date) {
    List<Appointment> res = [];

    appointments.forEach((keyDate, value) {
      if (keyDate.day == date.day &&
          keyDate.year == date.year &&
          keyDate.month == date.month) {
        res += value;
      }
    });

    return res;
  }

  //gib die Summe an Zeit für alle Termine für einen Tag zurück
  int getTotalBookedDurrationByDay(DateTime date) {
    //Appointments für einen Tag auslesen
    List<Appointment> appointmentsDay = getAppointmentsByDate(date);
    int totalDurration = 0;
    for (var appointment in appointmentsDay) {
      totalDurration += appointment.durration.toInt();
    }

    return totalDurration;
  }

  int getTotalAvailableDurrationByDay(DateTime date) {
    //Wochentag und deren Arbeitzeiten auslesen
    WorkingTime workingTime = WorkingTime(
        day: 0,
        begin: DateTime(2018, 12, 23, 10, 00),
        end: DateTime(2018, 12, 23, 18, 00));

    //  workingTimes[date.weekday];

    // berechne verfübare Zeit Fall Minute differenz ist minus einkalkuieren
    int availableDurration =
        (workingTime.end.hour - workingTime.begin.hour) * 60 +
            (workingTime.end.minute - workingTime.begin.minute);

    return availableDurration;
  }

  int lastIndex = 0;
  //gebe true zurück wenn das Ende der appointments erreicht wurde
  bool indexIsNotReached = true;
  bool checkedBeforeFirstAppointment = false;
  bool checkedBeforeFirstAppointmentCheck = false;

  List<Appointment> searchFreeAppointmentBeforeFirstElement(
      List<Appointment> appointmentsDay,
      int neededDurration,
      DateTime date,
      Cart cart) {
    //vorersten termin

//nach buchungsprozess -> checkedBeforeFirstAppointment =true;
    List<Appointment> res = [];

    int possibleAppointmentsValue =
        areAppointmentsAvailableBegin(appointmentsDay, 0, neededDurration);

    if (possibleAppointmentsValue > 0) {
      res.addAll(createAppointmentsForSpecificTimeReverse(
          possibleAppointmentsValue, date, 0, neededDurration, cart));
    }
    return res;
  }

  //sucht appountments und gibt nur die gefunden zurück
  //das heißt später mussen diese appointments zu possibleapointments hinzugefügt werden
  //wobei possible appointments eine map ist  verwaltet in der cart
  List<Appointment> searchFreeAppointment(
      int neededDurration, DateTime date, Cart cart) {
    //Appointments für den ausgewählten Tag auslesen
    List<Appointment> appointmentsDay = getAppointmentsByDate(date);

    //berechne die gesamte dauer aller buchungen
    int totalBookedDurration = getTotalBookedDurrationByDay(date);

    //hier werden später die möglichen termine gespeichert

    // verfügbare gesamt Arbeitszeiten brutto
    int totalAvailableDurration = getTotalAvailableDurrationByDay(date);

    //1. überprüfe ob generell genug freie Zeit verfügbar ist ansonsten leere liste zurück geben
    //   moreCounter++;
    List<Appointment> res = [];
    if (totalAvailableDurration - totalBookedDurration >= neededDurration &&
        indexIsNotReached) {
      //überprüfe ob es überhaupt termine gibt für den tag ansonsten 3 termine erstellen und zurpck geben
      if (appointmentsDay.isNotEmpty) {
        //wenn alle termine vor ersten überprüft wurde
        res.addAll(searchFreeAppointmentBeforeFirstElement(
            appointmentsDay, neededDurration, date, cart));
        //wir waren vorne
        for (int index = lastIndex; index < appointmentsDay.length; index++) {
          //überprüfe ob länge index +1 gibt
          //-> Um zu gucken wie viel Zeit zwische den
          //beiden Terminen liegt ist wichtig zu wissen ob überhaupt noch
          //ein Termin gibt.
          if (index + 1 < appointmentsDay.length) {
            //
            //erstelle nun die möglichen termine zwischen den terminen

            int possibleAppointmentsQuantity = areAppointmentsAvailable(
                appointmentsDay, index, neededDurration);
            lastIndex = index + 1;
            res.addAll(createAppointmentsForSpecificTime(
                possibleAppointmentsQuantity,
                date,
                index,
                neededDurration,
                cart));
          } else if (index + 1 == appointmentsDay.length) {
            //wenn das Ende der Liste erreicht wurde überprüfe ob nach dem letzten Termin verfügbare
            // Termine bis Arbeitsende  gibt
            {
              // DateTime endOfLastAppointment = appointmentsDay.last.end;
              // DateTime endOfWork = workingTimes[date.weekday]!.end;
              // int availableTimeBetweenLastAppointmentAndEndOfWork =
              //     getDifferenceInMinuteOf(appointmentsDay[index].end,
              //         appointmentsDay[index].begin);
              // //wenn Termine verfügbar sind berechne wie viele möglich sind erstelle diese und gib zurück
              // //wenn nicht keine termine verfügbar
              // if (availableTimeBetweenLastAppointmentAndEndOfWork >=
              //     neededDurration) {
              //   int possibleAppointmentsValue =
              //       availableTimeBetweenLastAppointmentAndEndOfWork ~/
              //           neededDurration;
              int possibleAppointmentsValue = areAppointmentsAvailableEndOfWork(
                  appointmentsDay, index, date, neededDurration);

              if (possibleAppointmentsValue > 0) {
                res.addAll(createAppointmentsForSpecificTime(
                    possibleAppointmentsValue,
                    date,
                    index,
                    neededDurration,
                    cart));

                return res;
              } else {
                return res;
              }
            }
          }
        }

        // wenn kein termin gibt überprüf ob ende ereicht wurde

        //wenn keine Termine enthalten sind dann erstelle von 0 an neue termine
        //fall vorne auch implemntieren wenn die liste null ist müssen die anfangswerte mit den anfangswerten dem arbeitsbeginn gleichen
      } else {
        int possibleAppointmentsValue =
            createFirstAppointments(neededDurration, date);

        //  print(possibleAppointmentsValue);
        res.addAll(createFirstAppointmentsValues(
            possibleAppointmentsValue, date, neededDurration, cart));
      }
    } else {
      return res;
    }

    return res;
  }

  int areAppointmentsAvailableBegin(
      List<Appointment> appointmentsDay, int index, int neededDurration) {
    DateTime beginOfWork = DateTime(2018, 12, 23, 10, 00);
    //erhalte die verfügbare Zeit zwischen appointment an positon index && index +1
    int availableTimeBetweenTwoAppointments =
        appointmentsDay[0].begin.difference(beginOfWork).inMinutes;
    // getDifferenceInMinuteOf(
    //     appointmentsDay[index].end, appointmentsDay[index + 1].begin);

    if (availableTimeBetweenTwoAppointments >= neededDurration) {
      return availableTimeBetweenTwoAppointments ~/ neededDurration;
      //zeiten sollten immer modulo 0 sein kein rest bsp verfügbare Zeit

    } else {
      return 0;
    }
  }

  int areAppointmentsAvailable(
      List<Appointment> appointmentsDay, int index, int neededDurration) {
    //erhalte die verfügbare Zeit zwischen appointment an positon index && index +1
    int availableTimeBetweenTwoAppointments = getDifferenceInMinuteOf(
        appointmentsDay[index].end, appointmentsDay[index + 1].begin);

    if (availableTimeBetweenTwoAppointments >= neededDurration) {
      return availableTimeBetweenTwoAppointments ~/ neededDurration;
      //zeiten sollten immer modulo 0 sein kein rest bsp verfügbare Zeit

    } else {
      return 0;
    }
  }

  List<Appointment> createFirstAppointmentsValues(
      int possibleAppointmentsQuantity,
      DateTime date,
      int neededDurration,
      Cart cart) {
    // int beginOfWorkHour = .hour;
    // int beginOfWorkMin = workingTimes[date.weekday]!.begin.minute;
    // int endOfWorkHour = workingTimes[date.weekday]!.end.hour;
    // int endOfWorkMin = workingTimes[date.weekday]!.end.minute;

//ersetzen mit dynmic
    var workTime = WorkingTime(
        day: 0,
        begin: DateTime(2018, 12, 23, 10, 00),
        end: DateTime(2018, 12, 23, 18, 00));

    // DateTime endOfWork = endOfLastAppointment
    //     .add(Duration(minutes: endofWorkMin, hours: endofWorkHour));
    //erhalte die verfügbare Zeit zwischen appointment an positon index && index +1

    List<Appointment> res = [];

    for (int indexPossibleAppointmentsQuantity = 0;
        indexPossibleAppointmentsQuantity < possibleAppointmentsQuantity;
        indexPossibleAppointmentsQuantity++) {
      //speichere alle möglichen Termine zwischen der zeit
      res.add(
        Appointment(
            id: id,
            date: DateTime(2018, 12, 23),
            state: AppointmentState.create,
            //zwischen welche beiden Termine
            begin: workTime.begin.add(Duration(
                minutes: indexPossibleAppointmentsQuantity * neededDurration)),
            end: workTime.begin.add(Duration(
                minutes: (indexPossibleAppointmentsQuantity * neededDurration) +
                    neededDurration)),
            workerId: id,
            durration: neededDurration.toDouble(),
            items: cart.items.values.toList(),
            total: cart.totalAmount.toDouble()),
      );
    }
    return res;
  }

  int createFirstAppointments(int neededDurration, DateTime date) {
    // int beginOfWorkHour = .hour;
    // int beginOfWorkMin = workingTimes[date.weekday]!.begin.minute;
    // int endOfWorkHour = workingTimes[date.weekday]!.end.hour;
    // int endOfWorkMin = workingTimes[date.weekday]!.end.minute;

    var begin = WorkingTime(
            day: 0,
            begin: DateTime(2018, 12, 23, 10, 00),
            end: DateTime(2018, 12, 23, 18, 00))
        .begin;

    var end = WorkingTime(
            day: 0,
            begin: DateTime(2018, 12, 23, 10, 00),
            end: DateTime(2018, 12, 23, 18, 00))
        .end;

    // DateTime endOfWork = endOfLastAppointment
    //     .add(Duration(minutes: endofWorkMin, hours: endofWorkHour));
    //erhalte die verfügbare Zeit zwischen appointment an positon index && index +1
    int availableTimeBetweenTwoAppointments =
        getDifferenceInMinuteOf(begin, end);

    if (availableTimeBetweenTwoAppointments >= neededDurration) {
      return availableTimeBetweenTwoAppointments ~/ neededDurration;
      //zeiten sollten immer modulo 0 sein kein rest bsp verfügbare Zeit

    } else {
      return 0;
    }
  }

  int areAppointmentsAvailableEndOfWork(List<Appointment> appointmentsDay,
      int index, DateTime date, int neededDurration) {
   

    DateTime endOfWork = DateTime(2018, 12, 23, 18, 00);
    // endOfWork.parse("2018,12,23,20:00");

    //die verfügbare Zeit zwischen
    int availableTimeBetweenLastAppointmentAndEndOfWork =
        //  endOfWork.difference(appointmentsDay[index].begin).inMinutes;
        getDifferenceInMinuteOf(appointmentsDay[index].end, endOfWork);
    //wenn Termine verfügbar sind berechne wie viele möglich sind erstelle diese und gib zurück
    //wenn nicht keine termine verfügbar
    if (availableTimeBetweenLastAppointmentAndEndOfWork >= neededDurration) {
      int possibleAppointmentsValue =
          availableTimeBetweenLastAppointmentAndEndOfWork ~/ neededDurration;

      return possibleAppointmentsValue;
    } else {
      return 0;
    }
  }

  List<Appointment> createAppointmentsForSpecificTimeReverse(
      int possibleAppointmentsQuantity,
      DateTime date,
      int index,
      int neededDurration,
      Cart cart) {
 

    DateTime beginOfWork = DateTime(2018, 12, 23, 10, 00);
    List<Appointment> res = [];

    for (int indexPossibleAppointmentsQuantity = 0;
        indexPossibleAppointmentsQuantity < possibleAppointmentsQuantity;
        indexPossibleAppointmentsQuantity++) {
      //speichere alle möglichen Termine zwischen der zeit
      res.add(Appointment(
          id: id,
          date: DateTime(2018, 12, 23),
          state: AppointmentState.create,
          //zwischen welche beiden Termine
          begin: beginOfWork.add(Duration(
              minutes: indexPossibleAppointmentsQuantity * neededDurration)),
          end: beginOfWork.add(Duration(
              minutes: (indexPossibleAppointmentsQuantity * neededDurration) +
                  neededDurration)),
          workerId: id,
          durration: neededDurration.toDouble(),
          items: cart.items.values.toList(),
          total: cart.totalAmount.toDouble()));
    }
    // lastSearchPoint = appointmentsDay[index].end.add(Duration(
    //     minutes:
    //         (possibleAppointmentsValue * neededDurration) + neededDurration));

    return res;
  }

  //methode um termine von bis einen bestimmtem Zeitpunkt erstellen

//erstelle termine für einen bestimmten zeitraum
// possibleAppointmentsValue = anzahl der Termine welche erstellt werden können
// index = nach oder vor welchen element
  List<Appointment> createAppointmentsForSpecificTime(
      int possibleAppointmentsQuantity,
      DateTime date,
      int index,
      int neededDurration,
      Cart cart) {
    List<Appointment> appointmentsDay = getAppointmentsByDate(date);

    List<Appointment> res = [];

    for (int indexPossibleAppointmentsQuantity = 0;
        indexPossibleAppointmentsQuantity < possibleAppointmentsQuantity;
        indexPossibleAppointmentsQuantity++) {
      //speichere alle möglichen Termine zwischen der zeit

      res.add(Appointment(
          id: id,
          date: DateTime(2018, 12, 23),
          state: AppointmentState.create,
          //zwischen welche beiden Termine
          begin: appointmentsDay[index].end.add(Duration(
              minutes: indexPossibleAppointmentsQuantity * neededDurration)),
          end: appointmentsDay[index].end.add(Duration(
              minutes: (indexPossibleAppointmentsQuantity * neededDurration) +
                  neededDurration)),
          workerId: id,
          durration: neededDurration.toDouble(),
          items: cart.items.values.toList(),
          total: cart.totalAmount.toDouble()));
    }
    // lastSearchPoint = appointmentsDay[index].end.add(Duration(
    //     minutes:
    //         (possibleAppointmentsValue * neededDurration) + neededDurration));

    return res;
  }

//errechne die Zeit welche zwischen beiden Daten liegen
  int getDifferenceInMinuteOf(DateTime begin, DateTime end) {
    int availableTime =
        (end.hour - begin.hour) * 60 + (end.minute - begin.minute);
    return availableTime;
  }

  int lastIndexCheck = 0;

  bool isAppointmentAvailable(int neededDurration, DateTime date, Cart cart) {
    //Appointments für den ausgewählten Tag auslesen
    List<Appointment> appointmentsDay = getAppointmentsByDate(date);

    //berechne die gesamte dauer aller buchungen
    int totalBookedDurration = getTotalBookedDurrationByDay(date);

    //hier werden später die möglichen termine gespeichert

    // verfügbare gesamt Arbeitszeiten brutto
    int totalAvailableDurration = getTotalAvailableDurrationByDay(date);

    //1. überprüfe ob generell genug freie Zeit verfügbar ist ansonsten leere liste zurück geben
    //   moreCounter++;

    if (totalAvailableDurration - totalBookedDurration >= neededDurration &&
        indexIsNotReached) {
      //überprüfe ob es überhaupt termine gibt für den tag ansonsten 3 termine erstellen und zurpck geben
      if (appointmentsDay.isNotEmpty) {
        //wenn alle termine vor ersten überprüft wurde
        if (checkedBeforeFirstAppointment) {
          //wir waren vorne
          for (int index = lastIndexCheck;
              index < appointmentsDay.length;
              index++) {
            //überprüfe ob länge index +1 gibt -> Um zu gucken wie viel Zeit zwische den beiden Terminen liegt ist wichtig zu wissen ob überhaupt noch ein Termin gibt.
            if (index + 1 < appointmentsDay.length) {
              //   //erstelle nun die möglichen termine zwischen den terminen

              int possibleAppointmentsQuantity = areAppointmentsAvailable(
                  appointmentsDay, index, neededDurration);
              lastIndexCheck = index + 1;
              return possibleAppointmentsQuantity > 0 ? true : false;
            } else if (index + 1 == appointmentsDay.length) {
              //wenn das Ende der Liste erreicht wurde überprüfe ob nach dem letzten Termin verfügbare
              // Termine bis Arbeitsende  gibt
              {
            
                int possibleAppointmentsValue =
                    areAppointmentsAvailableEndOfWork(
                        appointmentsDay, index, date, neededDurration);

                if (possibleAppointmentsValue > 0) {
                  return true;
                } else {
                  return false;
                }
              }
            }
          }
        } else if (checkedBeforeFirstAppointment == false) {
          //vorersten termin

//nach buchungsprozess -> checkedBeforeFirstAppointment =true;
          checkedBeforeFirstAppointment = true;

          int possibleAppointmentsValue = areAppointmentsAvailableBegin(
              appointmentsDay, 0, neededDurration);

          if (possibleAppointmentsValue > 0) {
            return true;
          } else {
            return false;
          }
        }
        // wenn kein termin gibt überprüf ob ende ereicht wurde

        //wenn keine Termine enthalten sind dann erstelle von 0 an neue termine
        //fall vorne auch implemntieren wenn die liste null ist müssen die anfangswerte mit den anfangswerten dem arbeitsbeginn gleichen
      } else {
        //   int possibleAppointmentsValue =
        //     createFirstAppointments(neededDurration, date);
        //    lastIndexCheck =  + 1;
        //  print(possibleAppointmentsValue);
        return false;
      }
    } else {
      return false;
    }
    throw {};
  }

  void clearAppointmentSearch() {
    lastIndex = 0;
    lastIndexCheck = 0;
    checkedBeforeFirstAppointment = false;
    checkedBeforeFirstAppointmentCheck = false;
  }
}

class WorkingTime {
  int day;
  DateTime begin;
  DateTime end;

  WorkingTime({required this.day, required this.begin, required this.end});
}

