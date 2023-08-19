import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../widgets/image/custom_image.dart';

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
                onPressed: () {},
                child: const Text('Recargar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
