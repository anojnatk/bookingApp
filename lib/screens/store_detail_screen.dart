import '/models/store.dart';
import '/providers/stores.dart';
import '/models/worker.dart';

import '/providers/cart.dart';

import '/widgets/business_info_box.dart';
import '/widgets/image_slider.dart';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'choose_time_and_worker_screen.dart';



class StoreDetailScreen extends StatefulWidget {
  static const routeName = "/storeDetail";

  const StoreDetailScreen({Key? key}) : super(key: key);

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Store store = Provider.of<Stores>(context, listen: true).choosenStore!;



    Cart _cart = Provider.of<Cart>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                store.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          leading: IconButton(
            iconSize: 20,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () async {

              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ImageSlider(),
              BusinessInfoBox(),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Dienstleistungen",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: store.getCategories.length,
                  itemBuilder: (context, index) {
                    return _buildServiceItems(store, context, index);
                  })
              // Container(
              //     width: size.width * 0.95,
              //     padding: const EdgeInsets.only(top: 10),
              //     child: ServiceArea()),
            ],
          ),
        ),
        persistentFooterButtons: _cart.items.isNotEmpty
            ? [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: getPersistentFooterButtons(context),
                )
              ]
            : []);
  }

  Widget _buildServiceItems(Store store, BuildContext context, int index) {
    Cart cart = Provider.of<Cart>(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          child: Text(
            store.categories[index].name,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
        Column(
          children: store
              .getServicesByCategory(store.getCategories[index])
              .map(
                (service) => Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(service.name,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Text(service.description,
                            style: Theme.of(context).textTheme.bodyText1),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${service.price}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            cart.items.containsKey(service.id)
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.add_task_outlined,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      cart.removeItem(service.id);
                                      List<Worker> _workers = Provider.of<
                                              Stores>(context, listen: false)
                                          .choosenStore!
                                          .getWorkersByServiceWhichTheyProvide(
                                              cart.items);

                                      for (var w in _workers) {
                                        w.clearAppointmentSearch();
                                      }

                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                     
                                      if (cart.items.length + 1 <= 3) {
                                        cart.addItem(service.id, service.price,
                                            service.name, service.durration);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Leider kannst du nicht mehr als 3 Dienstleistungen buchen!"),
                                        ));
                                      }

                                      List<Worker> _workers = Provider.of<
                                              Stores>(context, listen: false)
                                          .choosenStore!
                                          .getWorkersByServiceWhichTheyProvide(
                                              cart.items);

                                      _workers.forEach((w) {
                                        w.clearAppointmentSearch();
                                      });

                                    
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 2,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget getPersistentFooterButtons(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);
    Stores _stores = Provider.of<Stores>(context);

    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () async {
          await _stores.getWorkersFromDB();
          if (DateTime.now().timeZoneName == "CET" ||
              DateTime.now().timeZoneName == "CEST") {
            Navigator.of(context)
                .pushNamed(ChosseTimeAndWorkerScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Bitte stelle die Zeitzone auf Mitteleuropäische Zeit "),
            ));
          }

        },
        child: Row(children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2),
                shape: BoxShape.circle),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Text(
              _cart.items.length.toString(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          const Spacer(),
          Text("Weiter " + "(" + _cart.totalAmount.toString() + " €" + ")",
              style: const TextStyle(fontSize: 17, color: Colors.white)),
          const Spacer(),
          const Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          )
        ]));
  }
}
