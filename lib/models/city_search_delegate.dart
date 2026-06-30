import 'package:flutter/material.dart';

class CitySearchDelegate extends SearchDelegate<String> {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
        iconSize: 24,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back, size: 24),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Type a city name', style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      close(context, query);
    });

    return Container();
  }

  CitySearchDelegate({required String hintText})
      : super(
    searchFieldLabel: hintText,
    enableSuggestions: false,
    autocorrect: true,
    keyboardType: TextInputType.text,
  );
}
