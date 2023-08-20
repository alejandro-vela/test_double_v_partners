import 'package:flutter/material.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../widgets/image/custom_image.dart';

class DetailCharacterScreen extends StatelessWidget {
  const DetailCharacterScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final RickAndMortyBloc bloc = global<RickAndMortyBloc>();

    final String species = bloc.characters.results[id].species;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(bloc.characters.results[id].name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomImage(
              image: bloc.characters.results[id].image,
              height: size.height * 0.4,
              width: size.width,
              fit: BoxFit.fill,
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/static/portal.jpeg'),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Center(
                child: Text(
                  bloc.characters.results[id].name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                        species == 'Human' ? Icons.person : Icons.adb_rounded,
                        color: AppColors.black),
                    title: Text(
                      'Specie:  $species',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_tree_rounded,
                        color: AppColors.black),
                    title: Text(
                      'Status:  ${bloc.characters.results[id].status}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on_sharp,
                        color: AppColors.black),
                    title: Text(
                      'Origin:  ${bloc.characters.results[id].origin.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ListView.builder(
                      itemCount: bloc.characters.results[id].episode.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.tv_rounded,
                              color: AppColors.black),
                          title: Text(
                            'Episode:  ${bloc.characters.results[id].episode[index].split('/').last}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
