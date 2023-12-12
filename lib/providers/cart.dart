import '/models/cart_item.dart';

import '/models/appointment.dart';

import '/models/worker.dart';

import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  //jeder Mitarbeiter eine map mit int anzahl suchvorgänge (anzahl auf mehr gedrückt) und das dementsprechende ergebnis dazu
  Map<Worker, List<Appointment>> possibleAppointments = {};
  Map<String, CartItem> items = {};
  DateTime? choosenTime;
  Worker? choosenWoker;
  // Store? choosenStore;
  Appointment? choosenAppointment;
  double totalDurration = 0;
  bool appointmentsAv = true;
  bool workerIsChoosen = false;
  bool chooseWorkerTimeScreenDidAppear = false;

  setChoosenTime(DateTime newVal) {
    choosenTime = newVal;
    notifyListeners();
  }

  setPossibleAppointments(Map<Worker, List<Appointment>> newVal) {
    possibleAppointments = newVal;
    notifyListeners();
  }

  setItems(Map<String, CartItem> items) {
    this.items = items;
    notifyListeners();
  }

  Map<Worker, List<Appointment>> get getPossibleAppointments {
    return {...possibleAppointments};
  }

  List<String> getItemListIds() {
    List<String> result = [];

    items.forEach((key, value) {
      result.add(value.id);
    });
    return result;
  }

  setChoosenAppointment(Appointment? update) {
    choosenAppointment = update;
    if (update == null) {
      workerIsChoosen = false;
    }
    notifyListeners();
  }

  setChoosenWorker(Worker? update) {
    choosenWoker = update;

    if (update == null) {
    } else {
      searchAppointment(choosenTime!);
    }

    notifyListeners();
  }

  int get itemCount {
    return items.length;
  }

  double get getTotalDurration {
    var total = 0.0;

    items.forEach((key, value) {
      total += value.durration;
    });

    return total;
  }

  double get totalAmount {
    var total = 0.0;

    items.forEach((key, value) {
      total += value.price;
    });

    return total;
  }

  void removeItem(String serviceId) {
    items.remove(serviceId);
    totalDurration = getTotalDurration;
    if (choosenWoker != null) {
      choosenWoker!.clearAppointmentSearch();
    }

    clearTimeAndWorkerScreen();

    notifyListeners();
  }

  void searchAppointment(DateTime date) {
    if (!possibleAppointments.containsKey(choosenWoker!)) {
      possibleAppointments.addAll({
        choosenWoker!: choosenWoker!
            .searchFreeAppointment(totalDurration.toInt(), date, this)
      });
    }

    notifyListeners();
  }

  void addItem(String serviceId, double price, String title, double durration) {
    if (!items.containsKey(serviceId)) {
      items.addAll({
        serviceId: CartItem(
            id: serviceId, title: title, price: price, durration: durration)
      });
    }
    totalDurration = getTotalDurration;

    if (choosenWoker != null) {
      choosenWoker!.clearAppointmentSearch();
      clearTimeAndWorkerScreen();
    }

    notifyListeners();
  }

  void clearTimeAndWorkerScreen() {
    possibleAppointments = {};
    choosenWoker = null;
    choosenAppointment = null;
    workerIsChoosen = false;
  }

  void clear() {
    items = {};
    notifyListeners();
  }

  void setDefault() {
    setItems(items);
  }

  void updatePossibleAppoitments() {
    possibleAppointments = {};
    choosenWoker!.lastIndex = 0;
    choosenWoker!.lastIndexCheck = 0;
    notifyListeners();
  }
}
