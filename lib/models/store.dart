import 'package:customer/models/address.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:customer/models/worker.dart';

import '/models/cart_item.dart';

import '/models/category.dart';
import 'opening_time.dart';
import 'service.dart';

part 'json_serialization/store.g.dart';

@JsonSerializable()
class Store {
  String id;
  String name;
  Branch branch;
  Address address;
  double rating;
  Map<String, OpeningTime> openingTimes;
  List<Category> categories = [];
  Map<String, Worker> workers = {};
  Map<String, Service> services = {};
  Store(
      {required this.id,
      required this.name,
      required this.branch,
      required this.address,
      required this.rating,
      required this.openingTimes});

  factory Store.fromJson(String id, Map<String, dynamic> json) =>
      _$StoreFromJson(json,id)..id = id;

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  // factory Store.fromMap(Map<String, dynamic> data) {
  //   return Store(
  //       name: data["name:"],
  //       id: data["id:"],
  //       city: data["city"],
  //       rating: data["raiting"],
  //       branch: Branch.hairdresser,
  //       street: data["street"],
  //       postcode: data["postcode"] ?? 0);
  // }

  void makeDuplicatedServiceIdsInCategoryUnique() {}

  List<Service> getServicesByCategory(Category _category) {
    Category category = categories.firstWhere((c) => _category == c);
    return category.getServices;
  }

  List<Category> get getCategories {
    return categories;
  }

  void setCategories(List<Category> _categories) {
    categories = _categories;
  }

  List<Worker> getWorkersByServiceWhichTheyProvide(
      Map<String, CartItem> items) {
    List<Worker> res = [];

    List<String> serviceIds = items.keys.toList();

    int counter = 0;

    for (var worker in workers.values) {
      for (int j = 0; j < serviceIds.length; j++) {
        if (worker.services.contains(serviceIds[j])) {
          counter++;
          if (counter == serviceIds.length) {
            res.add(worker);
          }
        }
      }
      counter = 0;
    }

    return res;
  }

  // String get getBranchAsString {
  //   switch (branch) {
  //     case Branch.hairdresser:
  //       return "Friseursalon";
  //   }
}

enum Branch { hairdresser }
