
import 'package:customer/providers/stores.dart';
import 'package:customer/screens/store_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultItem extends StatelessWidget {
  String id, name, branch;
  double rating;

  SearchResultItem(
      {Key? key,
      required this.id,
      required this.name,
      required this.branch,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    Stores _stores = Provider.of<Stores>(context);
    return Column(children: [
      GestureDetector(
        onTap: () async {
          _stores.choosenStore =
              _stores.searchResult.firstWhere((store) => store.id == id);
          await _stores.getServicesFromDB(_stores.choosenStore!.id);
          Navigator.of(context).pushNamed(StoreDetailScreen.routeName);
        },
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.19,
              width: MediaQuery.of(context).size.width * 0.89,
              margin: EdgeInsets.all(8),
              child:
              
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:NetworkImage("https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/istockphoto-1244833615-1024x1024.jpg?alt=media&token=83c960f6-172d-4145-828b-919ec7ac7431"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ))),
  

  Row(children: [  Padding(
        padding: const EdgeInsets.only(left: 22.0),
        child: Align(alignment: Alignment.topLeft, child: Text(name)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Friseur',
              style: TextStyle(color: Colors.grey),
            )),
      ),],),
    
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.043,
            padding: const EdgeInsets.only(left: 20.0),
            child: TextButton(
                onPressed: () {
                  //  getLocationPermission();
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "200 m",
                          style:
                              TextStyle(color: Colors.black45, fontSize: 12)),
                  
                    ],
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.withOpacity(0.15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )))),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.043,
            padding: const EdgeInsets.only(left: 10.0),
            child: TextButton(
                onPressed: () {
                  //  getLocationPermission();
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: rating.toString(),
                          style:
                              TextStyle(color: Colors.black45, fontSize: 12)),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.black45,
                            size: 14,
                          ),
                        ),
                      ),
                      TextSpan(
                          text: "(100+)",
                          style:
                              TextStyle(color: Colors.black45, fontSize: 12)),
                    ],
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.withOpacity(0.15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )))),
          )
        ],
      ),
      SizedBox(
        height: 15,
      )
    ]);
  }
}
