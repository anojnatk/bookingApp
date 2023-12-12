import 'package:intl/date_symbol_data_local.dart';



import '/providers/cart.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChooseTime extends StatefulWidget {
  const ChooseTime({Key? key}) : super(key: key);

  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  bool thereIsAppointment = true;

  Widget getWidget(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat('EEE, MMM d, ' 'hh:mm');

    // _cart.possibleAppointments.forEach((key, value) {
    //   if (key == _cart.choosenWoker) {
    //     possibleAppointments.add(value)
    //   }
    // });
    // print(possibleAppointments.first);
    //überprüfe ob ein mitarbeiter ausgewählt wurde

    return _cart.workerIsChoosen
        ? Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            // width: (MediaQuery.of(context).size.width - 30) * 0.6,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Wähle einen Termin aus",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _cart.possibleAppointments[_cart.choosenWoker]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_cart.choosenAppointment == e) {
                                          _cart.setChoosenAppointment(null);
                                        } else {
                                          _cart.setChoosenAppointment(e);
                                        }
                                      });
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white70, width: 0),
                                          borderRadius: _cart
                                                      .possibleAppointments[
                                                          _cart.choosenWoker]!
                                                      .first ==
                                                  e
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10))
                                              : BorderRadius.zero),

                                      //  e == _cart.choosenAppointment
                                      //     ? Colors.black

                                      color: e == _cart.choosenAppointment
                                          ? Colors.black
                                          : Colors.white,
                                      elevation: 2,
                                      child: Container(
                                          child: Column(children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              dateFormat
                                                      .format(e.begin)
                                                      .toString() +
                                                  " Uhr",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: e ==
                                                          _cart
                                                              .choosenAppointment
                                                      ? Colors.white
                                                      : Colors.black),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "mittags",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: e ==
                                                        _cart.choosenAppointment
                                                    ? Colors.white
                                                    : Colors.black,

                                                fontWeight: FontWeight.bold,
                                                // color: e.isChoosen
                                                //     ? Colors.white
                                                //     : Colors.black
                                              ),
                                            )),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              (DateFormat("hh:mm")
                                                      .format(e.begin)
                                                      .toString() +
                                                  "-" +
                                                  (DateFormat("hh:mm")
                                                      .format(e.end)
                                                      .toString())),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: e ==
                                                        _cart.choosenAppointment
                                                    ? Colors.white
                                                    : Colors.black,
                                                // color: e.begin.toString() ==
                                                //         _cart.choosenAppointment
                                                //     ? Colors.white

                                                // color: e.isChoosen
                                                //     ? e.white
                                                //     : Colors.black
                                              ),
                                            )),
                                      ])),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  )
                  //     : SizedBox(),
                  // _cart.workerIsChoosen
                  //     ? _cart.appointmentsAv
                  //         ? getMoreButton(context)
                  //         : Text(
                  //             "Leider gibt es keine weiteren freien Termine!",
                  //             textAlign: TextAlign.center,
                  //           )
                  // : Text("Bitte wähle einen Mitarbeiter aus")
                ]))
        : Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Bitte wähle einen Mitarbeiter aus, um einen Termin auszuwählen.",
                textAlign: TextAlign.center,
              )
            ],
          );
  }

  Widget getMoreButton(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return TextButton(
        onPressed: () {
          _cart.searchAppointment(DateTime(2018, 12, 23));
        },
        child: const Text(
          "mehr",
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.black)))));
  }
}
