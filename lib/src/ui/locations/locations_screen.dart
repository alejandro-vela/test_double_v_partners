import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../utils/navigation_service.dart';
import '../../widgets/image/custom_image.dart';
import '../../widgets/search/search.dart';
import '../characters/charactes.dart';
import '../description/detail_screen.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  RickAndMortyBloc bloc = global<RickAndMortyBloc>();
  @override
  void initState() {
    bloc.add(const GetLocations(page: 1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is FinishWithError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      bloc: bloc,
      child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LocationsLoading) {
            return const Center(
                child: CustomImage(image: 'assets/static/loading.gif'));
          }
          if (state is FinishWithError) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(image: 'assets/static/error.gif'),
                  ElevatedButton(
                    onPressed: () {
                      global<RickAndMortyBloc>()
                          .add(const GetLocations(page: 1));
                    },
                    child: const Text('Recargar'),
                  ),
                ],
              )),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        dataList: bloc.locationsNames,
                        typeCard: TypeCard.location,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.locations?.results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(bloc.locations?.results[index].name ?? ''),
                        onTap: () {
                          NavigationService.push(
                              context: context,
                              screen: DetailScreen(
                                  id: index, typeCard: TypeCard.location),
                              routeName: DetailScreen.routeName);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
