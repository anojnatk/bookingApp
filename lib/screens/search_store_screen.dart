
import 'package:customer/providers/search_configuration.dart';
import 'package:customer/providers/stores.dart';
import 'package:customer/widgets/search_result_item.dart';

import 'package:provider/provider.dart';

import '../widgets/search_input_search_dialog.dart';
import 'package:flutter/material.dart';



class SearchStoreScreen extends StatefulWidget {
  SearchStoreScreen({Key? key}) : super(key: key);
  static const routeName = "/searchStore";

  @override
  State<SearchStoreScreen> createState() => _SearchStoreScreenState();
}

class _SearchStoreScreenState extends State<SearchStoreScreen> {
  

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SearchConfiguration _searchConfig =
        Provider.of<SearchConfiguration>(context);


    return Scaffold(
      body: ListView(
        children: [
          const SearchInputDialog(),
          _searchConfig.searchTerm.isNotEmpty
              ? SearchResultsListView(searchTerm: _searchConfig.searchTerm)
              : SizedBox(),
        ],
      ),
    );
  }
}

class SearchResultsListView extends StatefulWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  State<SearchResultsListView> createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stores _stores = Provider.of<Stores>(context);

    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: _stores.searchResult.length,
          itemBuilder: ((context, index) {
            return SearchResultItem(
                id: _stores.searchResult[index].id,
                name: _stores.searchResult[index].name,
                branch: _stores.searchResult[index].address.city,
                rating: _stores.searchResult[index].rating);
          }),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ));
  }
}









































//  stream: _stores.getStoreStreamBySearchTerm(
//             widget.searchTerm, _locationConfig.city!))
    // if (searchTerm == null) {
    //   return Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Icon(
    //           Icons.search,
    //           size: 64,
    //         ),
    //         Text(
    //           'Start searching',
    //           style: Theme.of(context).textTheme.headline5,
    //         )
    //       ],
    //     ),
    //   );
    // }

    // final fsb = FloatingSearchBar.of(context);
    // final SearchConfiguration _searchConfig =
    //     Provider.of<SearchConfiguration>(context);
    // final Stores _stores = Provider.of<Stores>(context);
    // final _storesDb = _stores.dbStores;

    // //  StreamBuilder(builder: (context,snapshot){

    // //     },
    // //     stream: _database.child("stores").equalTo((value){

    // //     }),
    // //     )

    // return NotificationListener<ScrollNotification>(
    //     onNotification: (scrollNotification) {
    //       return true;
    //     },
    //     child: Text(""));
  