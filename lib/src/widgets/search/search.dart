import 'package:flutter/material.dart';

import '../../bloc/rick_and_morty/model/model_characters.dart';
import '../../ui/characters/description/detail_screen.dart';
import '../../utils/navigation_service.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.dataList});
  final List<NameIndex> dataList;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<NameIndex> suggestions = dataList;

    if (query.isNotEmpty) {
      suggestions = dataList
          .toList()
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(suggestions[i].name,
              style: Theme.of(context).textTheme.bodyMedium),
          onTap: () {
            NavigationService.push(
                context: context,
                screen: DetailScreen(id: suggestions[i].id),
                routeName: DetailScreen.routeName);
            close(context, null);
          },
        );
      },
    );
  }
}
