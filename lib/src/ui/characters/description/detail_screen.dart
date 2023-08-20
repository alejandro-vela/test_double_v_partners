import 'package:flutter/material.dart';

import '../../../../global_locator.dart';
import '../../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../../theme/colors.dart';
import '../../../widgets/image/custom_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});
  static const routeName = '/detail';
  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final RickAndMortyBloc bloc = global<RickAndMortyBloc>();

  bool showMore = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String species = bloc.characters.results[widget.id].species;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          title: Text(bloc.characters.results[widget.id].name),
        ),
        body: Column(
          children: [
            CustomImage(
              image: bloc.characters.results[widget.id].image,
              height: size.height * 0.4,
              width: size.width,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Container(
                      width: size.width,
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
                          bloc.characters.results[widget.id].name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        'Status:  ${bloc.characters.results[widget.id].status}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on_sharp,
                          color: AppColors.black),
                      title: Text(
                        'Origin:  ${bloc.characters.results[widget.id].origin.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
