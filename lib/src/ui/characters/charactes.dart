import 'package:flutter/material.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../widgets/card/card.dart';
import '../../widgets/search/search.dart';

enum TypeCard {
  character,
  location,
  episode,
}

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final RickAndMortyBloc bloc = global<RickAndMortyBloc>();
  bool isGrid = false;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              focusNode.unfocus();
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    dataList: bloc.charactersNames,
                    typeCard: TypeCard.character),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Characters',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
              icon: isGrid
                  ? const Icon(Icons.app_registration_sharp,
                      color: AppColors.primaryColor)
                  : const Icon(Icons.list, color: AppColors.primaryColor),
            ),
          ),
          if (isGrid)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.4 / 4,
                children: List.generate(
                  bloc.characters.results.length,
                  (index) {
                    return CustomCards(
                      bloc: bloc,
                      index: index,
                      isGrid: isGrid,
                    );
                  },
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: bloc.characters.results.length,
                itemBuilder: (context, index) {
                  return CustomCards(
                    bloc: bloc,
                    index: index,
                    isGrid: isGrid,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
