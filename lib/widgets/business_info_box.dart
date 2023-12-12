
import 'package:customer/providers/stores.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import '/models/store.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BusinessInfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store _store = Provider.of<Stores>(context).choosenStore!;
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Friseur",
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.7), fontSize: 17),
              ),
            ),
            const Spacer(),
            Container(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ))
          ]),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "150" + " m",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '   ' + _store.address.city,
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontSize: 17)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(right: 12),
                child: RatingBarIndicator(
    rating: _store.rating.toDouble(),
    itemBuilder: (context, index) => Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 20.0,
    direction: Axis.horizontal,
),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 22),
                  child: Text(
                    _store.rating.toString(),
                    style: const TextStyle(fontSize: 18),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
