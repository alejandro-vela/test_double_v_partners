import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_locator.dart';
import '../../bloc/rick_and_morty/rick_and_morty_bloc.dart';
import '../../theme/colors.dart';
import '../../utils/navigation_service.dart';
import '../../widgets/image/custom_image.dart';
import '../home/home_scree.dart';
import 'error_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  RickAndMortyBloc _bloc = RickAndMortyBloc();
  late Animation<double> animation;
  late AnimationController animationController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);

  @override
  void initState() {
    _bloc = global<RickAndMortyBloc>();
    _bloc.add(const GetCharacters(page: 1));
    _animationController(begin: 0.0, end: 0.8);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _animationController(
      {int? duration, required double begin, required double end}) {
    animationController = AnimationController(
        duration: Duration(milliseconds: duration ?? 800), vsync: this);
    animation = Tween(begin: begin, end: end).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: BlocListener<RickAndMortyBloc, RickAndMortyState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is CharactersLoaded) {
            _animationController(begin: 0.8, end: 1.0);
            await animationController.forward().then(
                  (value) => {
                    NavigationService.pushAndRemoveUntil(
                      context: context,
                      screen: const HomeScreen(),
                      routeName: HomeScreen.routeName,
                    )
                  },
                );
          }
          if (state is FinishWithError) {
            _animationController(begin: 0.8, end: 1.0);
            await animationController.forward().then(
                  (value) => {
                    NavigationService.pushAndRemoveUntil(
                        context: context,
                        screen: const ErrorScreen(),
                        routeName: ErrorScreen.routeName)
                  },
                );
          }
        },
        child: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomImage(
                      image: 'assets/static/dvp_logo.png',
                      height: size.height * 0.1,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: size.width * 0.4,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          minHeight: 5.0,
                          value: animation.value,
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
