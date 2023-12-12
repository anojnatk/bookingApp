import 'package:customer/models/appointment.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  // List<String> searchHistory = [];

  String lastLocation = "";
  static const historyLength = 5;
  Map<String, Appointment> bookings = {
    "Test": Appointment(
        id: "djsfösj",
        date: DateTime(2018, 12, 23),
        begin: DateTime(2018, 12, 23, 17, 45),
        end: DateTime(2018, 12, 23, 18, 00),
        state: AppointmentState.create,
        workerId: "default",
        durration: 60,
        items: [],
        total: 15)
  };

  // void addCityToSearchHistory(String city) {
  //   if (!searchHistory.contains(city)) {
  //     searchHistory.add(city);

  //     // putSearchTermFirst(city);

  //   } else {
  //     if (searchHistory.length > historyLength) {
  //       searchHistory.removeRange(0, searchHistory.length - historyLength);
  //       // }
  //     }
  //   }
  // }

  // void deleteSearchTerm(String term) {
  //   searchHistory.removeWhere((t) => t == term);
  //   //   filteredSearchHistory = filterSearchTerms(filter: null);
  // }

  // void putSearchTermFirst(String term) {
  //   deleteSearchTerm(term);

  //   addCityToSearchHistory(term);
  // }

  Map<String, Appointment> get getBookings {
    return {...bookings};
  }

  void setLastLocation(String value) {
    lastLocation = value;
    notifyListeners();
  }
}
