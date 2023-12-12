import 'package:customer/providers/stores.dart';

import 'package:provider/provider.dart';

import '/providers/search_configuration.dart';
import 'package:flutter/material.dart';

class SearchInputDialog extends StatefulWidget {
  const SearchInputDialog({Key? key}) : super(key: key);

  @override
  State<SearchInputDialog> createState() => _SearchInputDialogState();
}

class _SearchInputDialogState extends State<SearchInputDialog> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchConfiguration _searchConfig =
        Provider.of<SearchConfiguration>(context);

    Stores _stores = Provider.of<Stores>(context);
    return Padding(
      padding: const EdgeInsets.only(
          top: 35.0, left: 20.0, right: 20.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 40),
              blurRadius: 50,
              spreadRadius: 30,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
          focusNode: myFocusNode,
          onChanged: (value) {
            _searchConfig.searchTermIsSubmitted = false;
          },
          onSubmitted: (sTerm)  {
            _stores.searchResult = [];
            
            _stores
                .getStoresFromDB(sTerm)
                .then((value) => _searchConfig.setSearchTerm(sTerm));
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: _searchConfig.searchTerm.isEmpty
                ? 'Search'
                : _searchConfig.searchTerm,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
        ),
      ),
    );
  }
}
