import 'package:customer/models/appointment.dart';

import '/providers/user.dart';
import '/screens/store_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyBookingScreen extends StatelessWidget {
  static const routeName = "/mybooking";
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
   

    String getDateFormat(DateTime date) {
      return DateFormat('EEE hh:mm dd-MM-yy').format(date);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(StoreDetailScreen.routeName);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Meine Buchungen",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(
          children: _user.getBookings.values
              .map(
                (appointment) => 
                
                
                Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              elevation: 20,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              context: context,
                              builder: (context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: getMyBookingItemMenu(
                                        appointment, context));
                              });
                        },
                        child: getMyBookingItem(appointment))),
              )
              .toList(),
        ));
  }

  Widget getMyBookingItem(Appointment appointment) {
   
    DateFormat dateFormatStandard = DateFormat("EEE, M/d/y");
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 0),
          borderRadius: BorderRadius.all(Radius.circular(25))),

      color: Colors.white,
      //       color: e.isChoosen ? Colors.black : Colors.white,
      elevation: 2,
      child: Container(
          child: Column(children: [
        SizedBox(
          height: 12,
        ),
        ListTile(
          leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage('https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/1000_F_205498258_AfQmtyR5kO5llwKd6fWRRxcc4xRUbQcb.jpg?alt=media&token=9c7cdd17-ce3a-483f-8d2f-9a08e95edf1a')),
          title: Text('Hamma'),
          subtitle: Text('Der Termin ist bestätigt'),
          isThreeLine: true,
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Datum",
                  style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 57, 56, 56),
                      fontWeight: FontWeight.bold),
                )),
            Container(
                margin: EdgeInsets.only(left: 25, top: 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  dateFormatStandard.format(appointment.begin),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                      // color: e.isChoosen
                      //     ? Colors.white
                      //     : Colors.black
                      ),
                )),
          ],
        )

        ///
        //
        ///
        ///
      ])),
    );
  }

  Widget getMyBookingItemMenu(Appointment appointment, BuildContext context) {
    DateFormat dateFormat = DateFormat("EEE, M/d/y hh:mm");
    DateFormat dateFormatOnlyHHmm = DateFormat("hh:mm");
    final User _user = Provider.of<User>(context);
    const TextStyle textStyle =
        TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300
            // color: e.isChoosen
            //     ? Colors.white
            //     : Colors.black
            );

    const TextStyle textStyleTitle = TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500);

    return Container(
        child: Column(children: [
      SizedBox(
        height: 10,
      ),
      ListTile(
        leading: CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage('https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/1000_F_205498258_AfQmtyR5kO5llwKd6fWRRxcc4xRUbQcb.jpg?alt=media&token=9c7cdd17-ce3a-483f-8d2f-9a08e95edf1a')),
        title: Text('Hamma'),
        subtitle: Text('Der Termin ist bestätigt'),
        isThreeLine: true,
      ),
      Divider(
        color: Colors.grey,
      ),
      SizedBox(
        height: 15,
      ),
      Column(children: [
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: const Text(
                "Datum",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Text(
                  dateFormat.format(appointment.begin) +
                      " - " +
                      dateFormatOnlyHHmm.format(appointment.end) +
                      " Uhr",
                  style: textStyle)),
        ]),
        SizedBox(height: 15),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Status",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Text('Bestätigt', style: textStyle)),
        ]),
        SizedBox(height: 15),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Mitarbeiter",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,

              child: Text('Stefan', style: textStyle)),
        ]),
        SizedBox(height: 15),
        Column(children: [
          Row(children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: const Text(
                  "Dienstleistung",
                  style: textStyleTitle,
                )),
            Spacer(),
            Container(
                margin: const EdgeInsets.only(left: 25, top: 0),
                padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                //   alignment: Alignment.centerLeft,

                child: Text('Haare schneiden',
                    maxLines: 3, style: textStyle)),
          ]),
        ]),
        SizedBox(height: 15),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Preis",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,

              child:
                  Text(appointment.total.toStringAsFixed(2), style: textStyle)),
        ]),
        SizedBox(height: 15),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Dauer",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Text(appointment.durration.toStringAsFixed(0) + " min",
                  style: textStyle)),
        ]),
        SizedBox(height: 15),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Buchungsnummer",
                style: textStyleTitle,
              )),
          Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 25, top: 0),
              //   alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Text("B232115", style: textStyle)),
        ])
      ]),
      Spacer(),
      Divider(),
      IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 3),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Zurück',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Spacer(),
            VerticalDivider(
              thickness: 0.2,
              color: Colors.black,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 3),
              child: TextButton(
                onPressed: () {
                  _user.bookings.remove(appointment);
                },
                child: const Text(
                  'Stornieren',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      )

      ///
      //
      ///
      ///
    ]));
  }
}
