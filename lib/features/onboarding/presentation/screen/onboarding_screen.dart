import 'package:aklni/core/utils/helper/responsive_ui_helper/size_helper_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/helper/responsive_ui_helper/size_provider.dart';
import '../widgets/card_slider_container.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
       body: Stack(
      children: [
        Container(
          height: context.sizeProvider.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: context.isLandscape ? context.setHeight(20) : context.setHeight(300),
          bottom: context.isLandscape ? context.setHeight(30) : context.setHeight(44),
          left:context.isLandscape? context.setWidth(18): context.setWidth(32),
          right:context.isLandscape? context.setWidth(18): context.setWidth(32),
          child: SizeProvider(
            baseSize: const Size(311, 350),
            width: context.setMinSize(311),
            height: context.setMinSize(350),
            child: Builder(
              builder: (context) {
                return const CardSliderContainer();
              }
            ),
          ),
        ),
      ],
    ),
          ),
        );
  }
}