import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'global_locator.dart';
import 'src/bloc/observer_bloc.dart';
import 'src/theme/theme.dart';
import 'src/ui/splash_screen/splash_screen.dart';

Future<void> main() async {
  setupGlobalLocator();
  Bloc.observer = ObserverBloc();
  runApp(const DVP());
}

class DVP extends StatelessWidget {
  const DVP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DVP',
      theme: lightThemeData,
      home: const SplashScreen(),
    );
  }
}
