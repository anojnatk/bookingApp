import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:customer/providers/stores.dart';

import '/models/cart_item.dart';
import '/providers/cart.dart';
import '/models/store.dart';

//import '/screens/my_booking_screen.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'my_booking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);
  static const routeName = "/checkout";

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);
    //  Worker _worker = _cart.choosenWoker!;
    Store _store = Provider.of<Stores>(context).choosenStore!;
    List<CartItem> _cartItems = _cart.items.values.toList();
    DateFormat dateFormat = DateFormat('EEE, MMM d, ' 'hh:mm');

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Checkout",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n' + _store.name,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ]),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(25)),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage('https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/1000_F_205498258_AfQmtyR5kO5llwKd6fWRRxcc4xRUbQcb.jpg?alt=media&token=9c7cdd17-ce3a-483f-8d2f-9a08e95edf1a')),
                  title: Text(_store.name),
                  subtitle: Text(_store.address.street +
                      ", " +
                      _store.address.postcode +
                      _store.address.city),
                  isThreeLine: true,
                ),
              ),
            ),

            //________________________________________________________
            Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height *
                    getHeightFactor(_cartItems.length)-50,
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mitarbeiter",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            //   margin: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _cart.choosenWoker!.firstName,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),

                      ///________________________________________________________________________________
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Datum",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            //   margin: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dateFormat.format(_cart.choosenTime!),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),

                      //____________________________________________________________________________

                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dauer",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            //    margin: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _cart.totalDurration.toString() + " min",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                      //____________________________________________________________________________

                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gesamtbetrag",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            //    margin: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _cart.totalAmount.toStringAsFixed(2) + "€",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),

                      //____________________________________________________________________________

                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dienstleistung",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 20, top: 20, right: 20),
                              //   margin: EdgeInsets.all(20),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                  children: _cartItems
                                      .map((e) => Text(e.title))
                                      .toList())),
//______________________________________________________________________
                        ],
                      ),
                    ])))
          ],
        ),
        persistentFooterButtons: [getPersistentFooterButtons(context)]);
  }

  Widget getPersistentFooterButtons(BuildContext context) {
    Cart cart = Provider.of<Cart>(context, listen: false);
    //  User _user = Provider.of<User>(context, listen: false);
    Store store = Provider.of<Stores>(context, listen: false).choosenStore!;
    //  List<Worker> _workersByService =
    //     store.getWorkersByServiceWhichTheyProvide(cart.items);

    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () {
          cart.choosenTime = DateTime(2018, 12, 23);
          //       store.addAppointment(cart.choosenAppointment, cart.choosenWoker);

          // store.workers[cart.choosenWoker!.id]!
          //     .appointments[cart.choosenAppointment!.date]!
          //     .add(cart.choosenAppointment!);
          //  store.workers[0].appointments[DateTime(2018, 12, 23)]!
          //    .add(cart.choosenAppointment!);

          // _user.bookings
          //     .addAll({DateTime.now().toString(): cart.choosenAppointment!});
          // // _user.
          //  bookings.sort((a, b) => a.begin.compareTo(b.begin));

          // cart.choosenWoker!.appointments[cart.choosenAppointment!.date]!
          //     .add(cart.choosenAppointment!);

          FirebaseFirestore.instance
              .collection("/stores/" +
                  store.id +
                  "/workers/" +
                  cart.choosenWoker!.id +
                  "/appointments")
              .add(cart.choosenAppointment!.toJson());

          Navigator.of(context)
              .pushNamed(MyBookingScreen.routeName)
              .then((value) {
            cart.setItems({});
            cart.setPossibleAppointments({});
            cart.choosenWoker!.lastIndex = 0;
            cart.choosenWoker!.checkedBeforeFirstAppointment = false;

            cart.setChoosenAppointment(null);
            cart.setChoosenWorker(null);
          });
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
              cart.items.length.toString(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          const Spacer(),
          Text("Weiter " + "(" + cart.totalAmount.toString() + " €" + ")",
              style: const TextStyle(fontSize: 17, color: Colors.white)),
          const Spacer(),
          const Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              LineIcons.shoppingBag,
              color: Colors.white,
            ),
          )
        ]));
  }

  double getHeightFactor(int length) {
    if (length == 1) {
      return 0.39;
    } else if (length == 2) {
      return 0.41;
    } else if (length == 3) {
      return 0.45;
    }
    return 0.35;
  }
}
