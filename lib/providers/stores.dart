import 'package:customer/firebase_options.dart';
import 'package:customer/models/category.dart';
import 'package:firebase_core/firebase_core.dart';

import '/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/models/appointment.dart';

import 'package:customer/models/service.dart';
import 'package:customer/models/worker.dart';

import 'package:flutter/material.dart';

import 'package:customer/models/store.dart';

class Stores with ChangeNotifier {
  List<Store> searchResult = [];

  Store? choosenStore;

  Future<void> getStoresFromDB(String sTerm) async {
    try {

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await FirebaseFirestore.instance
          .collection("stores")
          .where("name", isEqualTo: sTerm)
          .get()
          .then((value) {
        for (var storeDB in value.docs) {
          searchResult.add(Store.fromJson(storeDB.id, storeDB.data()));
        }
        print(value.docs);
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getServicesFromDB(String storeId) async {
    var services = choosenStore!.services;
 Firebase.initializeApp();
    try {
      await FirebaseFirestore.instance
          .collection("stores/" + storeId + "/services")
          .get()
          .then((value) {
        for (var serviceDB in value.docs) {
          services.addAll(
              {serviceDB.id: Service.fromJson(serviceDB.id, serviceDB.data())});
        }
        getCategoriesFromDB(storeId);
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCategoriesFromDB(String storeId) async {

    var categories = choosenStore!.categories;
 Firebase.initializeApp();
    try {
      await FirebaseFirestore.instance
          .collection("stores/" + storeId + "/categories")
          .get()
          .then((value) {
        for (var categoryDB in value.docs) {
          categories.add(Category.fromJson(categoryDB.data()));
          print(List<String>.from(categoryDB["services"]));

          var list = List<String>.from(categoryDB["services"]);

          for (var element in list) {
            element.trim();
          }

          categories.last.initializeServices(
              choosenStore!.services.values.toList(),
              list,
              choosenStore!.categories);
        }

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getWorkersFromDB() async {
    
    try {
      await FirebaseFirestore.instance
          .collection("stores/" + choosenStore!.id + "/workers")
          .get()
          .then((value) {
        for (var data in value.docs) {
          choosenStore!.workers
              .addAll({data.id: Worker.fromJson(data.id, data.data())});
        }

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  List<String> getServicesListFromDB(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
 
    List<String> res = data["services"]
        .toString()
        .replaceAll(" ", "")
        .replaceAll(" ", "")
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");

    return res;
  }

//Methode lädt die Termine vom Server Achtung: aktuell nur möglich wenn die Termine richtig
// Zeitlich geordnet wurden
//Items werden nicht behandelt
  Future<void> getAppointmentsByWorkerFromDB(String workerId) async {
    print("StoreId" + choosenStore!.id + "WorkerId" + workerId);
    try {
      await FirebaseFirestore.instance
          .collection("stores/" +
              choosenStore!.id +
              "/workers/" +
              workerId +
              "/appointments")
          .get()
          .then((value) {
        for (var data in value.docs) {
          Timestamp date = data["date"];

          if (choosenStore!.workers[workerId]!.appointments
              .containsKey(date.toDate())) {
            choosenStore!.workers[workerId]!.appointments[date.toDate()]!
                .add(Appointment.fromJson(data.data(),data.id));
            // choosenStore!.workers[workerId]!.appointments[date.toDate()]!
            //     .sort((c, x) => c.begin.compareTo(x.begin));
          } else {
            choosenStore!.workers[workerId]!.appointments.addAll({
              date.toDate(): [Appointment.fromJson(data.data(),data.id)]
            });

            // choosenStore!.workers[workerId]!.appointments[date.toDate()]!
            //     .sort((c, x) => c.begin.compareTo(x.begin));
          }
        }
      });

      notifyListeners();
    } catch (e) {
      print("Error Mitarbeiter Temrine laden" + e.toString());
    }

    List<CartItem> getItemsFromMap(
        QueryDocumentSnapshot<Map<String, dynamic>> data) {
      List<CartItem> items = [];

      data["cartItem"].forEach((key, value) {
        items.add(CartItem.fromJson(value));
      });

      return items;
    }
  }
}
