import 'package:customer/screens/checkout_screen.dart';

import '/providers/cart.dart';

import '/widgets/choose_time.dart';
import '/widgets/choose_worker.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ChosseTimeAndWorkerScreen extends StatelessWidget {
  static const routeName = "/timeWorker";
  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);
    _cart.chooseWorkerTimeScreenDidAppear = true;
    _cart.choosenTime = (DateTime(2018, 12, 23));
    return Scaffold(
        // bottomSheet: _cart.choosenAppointment == null
        //     ? SizedBox.shrink()
        //     :
        //  bottomSheet: getFooter(context),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "Wähle einen Mitarbeiter aus",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          leading: IconButton(
            iconSize: 20,
            icon: const Icon(LineIcons.arrowLeft),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
              //
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ChooseWorker(),
              ChooseTime()
              //    ChooseTime()
              //   ChooseTime()
            ],
          ),
        ),
        persistentFooterButtons: !(_cart.choosenAppointment == null)
            ? [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: getPersistentFooterButtons(context),
                )
              ]
            : []);
  }

  Widget getPersistentFooterButtons(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () {
          if (DateTime.now().timeZoneName == "CET" ||
              DateTime.now().timeZoneName == "CEST") {
            Navigator.of(context).pushNamed(CheckoutScreen.routeName);
          }

          _cart.choosenTime = _cart.choosenAppointment!.begin;
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
              LineIcons.shoppingBag,
              color: Colors.white,
            ),
          )
        ]));
  }
}
