import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../widgets/image/custom_image.dart';

class DetailLocationScreen extends StatefulWidget {
  const DetailLocationScreen({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<DetailLocationScreen> createState() => _DetailLocationScreenState();
}

class _DetailLocationScreenState extends State<DetailLocationScreen> {
  final RickAndMortyBloc bloc = global<RickAndMortyBloc>();
  @override
  void initState() {
    bloc.add(GetResidents(locationId: widget.id));
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
          if (state is FinishWithResidentError) {
            return const Scaffold(
              body: Center(
                  child: CustomImage(image: 'assets/static/loading.gif')),
            );
          }
          if (state is ResidentsLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.secondaryColor,
                title: Text(bloc.locations!.results[widget.id].name),
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
                          bloc.locations!.results[widget.id].name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.location_on_sharp,
                          color: AppColors.black),
                      title: Text(
                        'Type:  ${bloc.locations!.results[widget.id].type}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on_sharp,
                          color: AppColors.black),
                      title: Text(
                        'Dimension:  ${bloc.locations!.results[widget.id].dimension}',
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
                                'Residents:  ${state.residents[index].name}',
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
