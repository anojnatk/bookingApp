import 'service.dart';

import 'package:json_annotation/json_annotation.dart';
part 'json_serialization/category.g.dart';

@JsonSerializable()
class Category {
  String name;
  List<Service> services = [];

  List<Service> get getServices {
    return [...services];
  }

  Category(this.name);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  void initializeServices(List<Service> _allServices, List<String> serviceIds,
      List<Category> categories) {
    List<Service> allServicesFromCategoryAsList = getServicesAsList(categories);

    for (var service in _allServices) {
      if (serviceIds.contains(service.id)) {
        if (!allServicesFromCategoryAsList.contains(service)) {
          services.add(service);
        }
      }
    }
  }

  List<Service> getServicesAsList(List<Category> categories) {
    List<Service> sum = [];

    for (var category in categories) {
      sum += category.services;
    }

    return sum;
  }
}
