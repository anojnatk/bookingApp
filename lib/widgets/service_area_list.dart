import '/providers/cart.dart';

import '/models/store.dart';

import 'package:flutter/material.dart';
import '/models/category.dart';
import 'package:provider/provider.dart';

class ServiceAreaList extends StatefulWidget {
  @override
  _ServiceAreaListState createState() => _ServiceAreaListState();
}

class _ServiceAreaListState extends State<ServiceAreaList> {
  Widget getWidget(BuildContext context, Category category) {
    final _services =
        Provider.of<Store>(context).getServicesByCategory(category);
    final _cart = Provider.of<Cart>(context);

    return Container(
        // width: (MediaQuery.of(context).size.width - 30) * 0.6,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 30),
      Text(
        category.name,
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _services
            .map((service) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_cart.items.containsKey(service.id)) {
                            _cart.addItem(service.id, service.price,
                                service.name, service.durration);
                          } else {
                            _cart.removeItem(service.id);
                          }
                        });
                      },
                      child: Card(
                        color: _cart.items.containsKey(service.id)
                            ? Colors.black
                            : Colors.white,
                        elevation: 1,
                        child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    service.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            _cart.items.containsKey(service.id)
                                                ? Colors.white
                                                : Colors.black),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    service.description,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            _cart.items.containsKey(service.id)
                                                ? Colors.white
                                                : Colors.black),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    service.price.toString() + " €",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            _cart.items.containsKey(service.id)
                                                ? Colors.white
                                                : Colors.black),
                                  )),
                            ])),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final _categories = Provider.of<Store>(context).getCategories;

    return Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: _categories
              .map(
                (e) => Padding(
                    padding: const EdgeInsets.only(left: 10.5, right: 10.5),
                    child: getWidget(context, e)
                    // Tab(
                    //   child: Text(
                    //     e.name,
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    ),
              )
              .toList(),
        ));
  }
}
