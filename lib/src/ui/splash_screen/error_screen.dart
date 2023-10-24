import 'package:flutter/material.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../utils/navigation_service.dart';
import '../../widgets/image/custom_image.dart';
import 'splash_screen.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CustomImage(
                image: 'assets/static/no_conection.gif',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  global<RickAndMortyBloc>().add(const GetCharacters(page: 1));
                  NavigationService.pushAndRemoveUntil(
                      context: context,
                      screen: const SplashScreen(),
                      routeName: SplashScreen.routeName);
                },
                child: const Text('Recargar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
