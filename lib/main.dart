
import 'package:customer/providers/cart.dart';
import 'package:customer/providers/search_configuration.dart';
import 'package:customer/providers/stores.dart';
import 'package:customer/providers/user.dart';
import 'package:customer/screens/store_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'screens/checkout_screen.dart';
import 'screens/choose_time_and_worker_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_booking_screen.dart';
import 'screens/search_store_screen.dart';

main()  {

  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'de';
    Firebase.initializeApp();

    final ThemeData theme = ThemeData(
        primaryTextTheme:
            TextTheme(subtitle1: TextStyle(fontWeight: FontWeight.w100)));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SearchConfiguration()),
        ChangeNotifierProvider.value(value: Stores()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: User())
      ],
      child: MaterialApp(
          title: 'Datetify Customer',
          theme: ThemeData(
              primaryColor: Colors.black,
              colorScheme: theme.colorScheme.copyWith(secondary: Colors.white),
              fontFamily: "Muli"),
          home: HomeScreen(),
          routes: {
            ChosseTimeAndWorkerScreen.routeName: (ctx) =>
                ChosseTimeAndWorkerScreen(),
            CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
            MyBookingScreen.routeName: (ctx) => MyBookingScreen(),
            StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
            SearchStoreScreen.routeName: (ctx) => SearchStoreScreen()
          }),
    );
  }
}
