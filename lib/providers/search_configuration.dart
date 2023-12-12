import 'package:flutter/material.dart';

class SearchConfiguration with ChangeNotifier {
  String searchTerm = "";
  bool searchTermIsSubmitted = false;

  void setSearchTerm(String sTerm) {
    searchTerm = sTerm;
    searchTermIsSubmitted = true;
    notifyListeners();
  }
}
