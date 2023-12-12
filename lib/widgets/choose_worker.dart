import 'package:customer/providers/stores.dart';

import '../models/worker.dart';
import '/providers/cart.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseWorker extends StatefulWidget {
  const ChooseWorker({Key? key}) : super(key: key);

  @override
  _ChooseWorkerState createState() => _ChooseWorkerState();
}

class _ChooseWorkerState extends State<ChooseWorker> {
  bool firstTime = true;
  // String _choosenWorkerId = "";
  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);
    Stores _stores = Provider.of<Stores>(context);

    List<Worker> _workers = Provider.of<Stores>(context)
        .choosenStore!

        //direkte verbindung mit DB
        .getWorkersByServiceWhichTheyProvide(_cart.items);

    return Center(
      child: SizedBox(
          height: 174,
          child: ListView.separated(
            separatorBuilder: (BuildContext ctx, int index) {
              return const SizedBox(
                width: 25,
              );
            },
            padding: const EdgeInsets.only(left: 50, top: 50),

            itemBuilder: (btx, i) {
              return Column(children: [
                // Container(
                //   width: 100,
                //   height: 100,
                //   child: Image.network(_workers.getWorker()[i].imageUrl),
                // ),
                // Text(_workers.getWorker()[i].firstName)

                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50))),
                  alignment: Alignment.centerLeft,
                  // margin: const EdgeInsets.only(left: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _cart.workerIsChoosen = true;
                      });

                      //später wenn suche abhängug von Zeit implementiert wird muss überprüft
                      //werden ob für das bestimmte datum die daten gelesen werden
                      //empty kann nicht benutz werden da liste auch leer sein kann deshalb
                      //mit bool werten arbeiten

//permanent überwachen ob TimeZone korrekt ist
//alternative lösung finden
                      if (DateTime.now().timeZoneName == "CET" ||
                          DateTime.now().timeZoneName == "CEST") {
                        if (_stores.choosenStore!.workers[_workers[i].id]!
                            .appointments.isEmpty) {
                          print("Termine von Mitarbeiter");
                          print(_stores.choosenStore!.workers[_workers[i].id]!
                              .appointments);
                          _stores
                              .getAppointmentsByWorkerFromDB(_workers[i].id)
                              .then((value) {
                            _cart.setChoosenWorker(_workers[i]);
                            _cart.searchAppointment(_cart.choosenTime!);
                          });
                        } else {
                          _cart.setChoosenWorker(_workers[i]);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Bitte stelle die Zeitzone auf Mitteleuropäische Zeit "),
                        ));
                      }
                    },
                    child: Column(
                      children: [
                        Opacity(
                          opacity: _cart.workerIsChoosen
                              ? _cart.choosenWoker == _workers[i]
                                  ? 1
                                  : 0.3
                              : 0.3,
                          child: ClipRRect(
                            child: Image(
                                image: NetworkImage(_workers[i].imageUrl)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _workers[i].firstName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            },
            itemCount: _workers.length,
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
