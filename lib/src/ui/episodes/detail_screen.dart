import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../widgets/image/custom_image.dart';

class DetailEpisodeScreen extends StatefulWidget {
  const DetailEpisodeScreen({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<DetailEpisodeScreen> createState() => _DetailEpisodeScreenState();
}

class _DetailEpisodeScreenState extends State<DetailEpisodeScreen> {
  final RickAndMortyBloc bloc = global<RickAndMortyBloc>();
  @override
  void initState() {
    bloc.add(GetResidents(episodeId: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<RickAndMortyBloc, RickAndMortyState>(
      listener: (context, state) {
        if (state is ResidentsLoaded) {}
      },
      bloc: bloc,
      child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ResidentsLoading) {
            return const Scaffold(
              body: Center(
                  child: CustomImage(image: 'assets/static/loading.gif')),
            );
          }
          if (state is FinishWithErrorResident) {
            return const Scaffold(
              body: Center(
                  child: CustomImage(image: 'assets/static/loading.gif')),
            );
          }
          if (state is ResidentsLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.secondaryColor,
                title: Text(bloc.episodes!.results[widget.id].name),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
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
                          bloc.episodes!.results[widget.id].name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.tv, color: AppColors.black),
                      title: Text(
                        'Air Date:  ${bloc.episodes!.results[widget.id].airDate}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.numbers_outlined,
                          color: AppColors.black),
                      title: Text(
                        'Episode:  ${bloc.episodes!.results[widget.id].episode}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.residents.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CustomImage(
                                image: state.residents[index].image,
                                height: 50,
                                width: 50,
                                borderRadius: 40,
                                fit: BoxFit.fill,
                              ),
                              title: Text(
                                'Protagonist:  ${state.residents[index].name}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
