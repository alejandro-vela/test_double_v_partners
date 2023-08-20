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
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    bloc.add(const GetLocations(page: 1));
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        bloc.locations!.info.next != null
            ? bloc.add(GetLocations(
                page: int.parse(bloc.locations!.info.next!.split('=').last)))
            // ignore: unnecessary_statements
            : null;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Container(
                  width: size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/static/portal.jpeg'),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Locations',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
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
                    controller: controller,
                    itemCount: (bloc.locations?.results.length ?? 0) + 1,
                    itemBuilder: (context, index) {
                      return index < (bloc.locations?.results.length ?? 0)
                          ? ListTile(
                              title: Text(
                                  bloc.locations?.results[index].name ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              onTap: () {
                                NavigationService.push(
                                    context: context,
                                    screen: DetailScreen(
                                        id: index, typeCard: TypeCard.location),
                                    routeName: DetailScreen.routeName);
                              },
                            )
                          : bloc.locations?.info.next != null
                              ? const Center(
                                  child: CustomImage(
                                      height: 50,
                                      width: 50,
                                      image: 'assets/static/loading.gif'),
                                )
                              : const Center();
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
