import 'package:flutter/material.dart';
import 'src/ui/splash_screen/splash_screen.dart';

Future<void> main() async {
  runApp(const DVP());
}

class DVP extends StatelessWidget {
  const DVP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DVP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
