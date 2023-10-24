import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../widgets/card/card.dart';
import '../../widgets/image/custom_image.dart';
import '../../widgets/search/search.dart';

enum TypeCard {
  character,
  location,
  episode,
}

enum SortItem { Name, Gender, Species }

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final RickAndMortyBloc bloc = global<RickAndMortyBloc>();
  final ScrollController controller = ScrollController();

  bool isGrid = false;
  FocusNode focusNode = FocusNode();
  SortItem? selectedMenu;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        bloc.characters.info.next != null
            ? bloc.add(GetCharacters(
                page: int.parse(bloc.characters.info.next!.split('=').last)))
            // ignore: unnecessary_statements
            : null;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<RickAndMortyBloc, RickAndMortyState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is FinishWithErrorEpisode) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is CharactersLoaded) {}
      },
      child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                        'Rick and Morty',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Row(
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
                          width: size.width * 0.8,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.darkGrey.withOpacity(.2),
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
                      PopupMenuButton(
                        initialValue: selectedMenu,
                        icon: const Icon(Icons.sort),
                        onSelected: (item) {
                          setState(() {
                            selectedMenu = item;
                          });
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: SortItem.Name,
                            child: Text('Name',
                                style: Theme.of(context).textTheme.bodyMedium),
                            onTap: () {
                              bloc.add(
                                  const SortCharacters(type: SortItem.Name));
                            },
                          ),
                          PopupMenuItem(
                            value: SortItem.Gender,
                            child: Text('Gender',
                                style: Theme.of(context).textTheme.bodyMedium),
                            onTap: () {
                              bloc.add(
                                  const SortCharacters(type: SortItem.Gender));
                            },
                          ),
                          PopupMenuItem(
                            value: SortItem.Species,
                            child: Text('Species',
                                style: Theme.of(context).textTheme.bodyMedium),
                            onTap: () {
                              bloc.add(
                                  const SortCharacters(type: SortItem.Species));
                            },
                          ),
                        ],
                      ),
                    ],
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
                          : const Icon(Icons.list,
                              color: AppColors.primaryColor),
                    ),
                  ),
                  if (isGrid)
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.4 / 4,
                          ),
                          controller: controller,
                          itemCount: bloc.characters.results.length + 1,
                          itemBuilder: (context, index) {
                            return index < bloc.characters.results.length
                                ? CustomCards(
                                    bloc: bloc,
                                    index: index,
                                    isGrid: isGrid,
                                  )
                                : bloc.characters.info.next != null
                                    ? const Center(
                                        child: CustomImage(
                                            height: 50,
                                            width: 50,
                                            image: 'assets/static/loading.gif'),
                                      )
                                    : const Center();
                          }),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: bloc.characters.results.length + 1,
                        itemBuilder: (context, index) {
                          return index < bloc.characters.results.length
                              ? CustomCards(
                                  bloc: bloc,
                                  index: index,
                                  isGrid: isGrid,
                                )
                              : bloc.characters.info.next != null
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
          }),
    );
  }
}
