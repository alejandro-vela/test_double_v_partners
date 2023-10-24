import 'package:flutter/material.dart';

import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../ui/characters/charactes.dart';
import '../../ui/description/detail_screen.dart';
import '../../utils/navigation_service.dart';
import '../image/custom_image.dart';

class CustomCards extends StatelessWidget {
  const CustomCards({
    super.key,
    required this.bloc,
    required this.index,
    required this.isGrid,
  });

  final RickAndMortyBloc bloc;
  final int index;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        NavigationService.push(
            context: context,
            screen: DetailScreen(id: index, typeCard: TypeCard.character),
            routeName: DetailScreen.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: <Widget>[
              CustomImage(
                image: bloc.characters.results[index].image,
                height: size.height * 0.3,
                width: size.width,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  bloc.characters.results[index].name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (!isGrid)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Status: ${bloc.characters.results[index].status}',
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
