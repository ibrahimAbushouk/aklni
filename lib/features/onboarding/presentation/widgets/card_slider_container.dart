import 'package:aklni/core/utils/helper/responsive_ui_helper/size_helper_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helper/responsive_ui_helper/size_provider.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class CardSliderContainer extends StatefulWidget {
  const CardSliderContainer({super.key});

  @override
  State<CardSliderContainer> createState() => _CardSliderContainerState();
}

class _CardSliderContainerState extends State<CardSliderContainer> {
  final CarouselSliderController _carouselController = CarouselSliderController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoaded) {
          final cards = state.cards;
          return Card(
            color: AppColors.mainColors.withOpacity(0.9),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.setMinSize(40)),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.setMinSize(21)),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: context.isLandscape
                          ? context.sizeProvider.height / 4.9
                          : context.sizeProvider.height / 2.9,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: cards.map((card) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(card.title,
                                    style: context.onBoardingTitleStyle,
                                    textAlign: TextAlign.center,
                                    maxLines: 3),
                                SizedBox(height: context.setMinSize(5)),
                                Text(card.subtitle,
                                    style: context.onBoardingDescriptionStyle,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  DotsIndicator(
                    dotsCount: cards.length,
                    position: _currentIndex.toDouble(),
                    decorator: DotsDecorator(
                      activeSize: Size(24, 6),
                      color: Color(0xFFC2C2C2),
                      activeColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(context.setMinSize(5.0)),
                      ),
                      activeShape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(context.setMinSize(5.0)),
                      ),
                    ),
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      _carouselController.animateToPage(index);
                    },
                  ),
                  Spacer(),
              _currentIndex >= cards.length - 1
                      ? SizeProvider(
                    baseSize: const Size(55, 55),
                    height: context.setMinSize(55),
                    width: context.setMinSize(55),
                    child: GestureDetector(
                      onTap: ()  {
                       context.read<OnboardingCubit>().finishOnboarding(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.mainColors,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                           context.read<OnboardingCubit>().finishOnboarding(context);
                          },
                          child: Text("Skip",
                              style: context.white14semiBold)),
                      GestureDetector(
                          onTap: () {
                            if (_currentIndex < cards.length - 1) {
                              _currentIndex++;
                              _carouselController
                                  .animateToPage(_currentIndex);
                              setState(() {});
                            }
                          },
                          child: Text("Next",
                              style: context.white14semiBold)),
                    ],


              ),
                ],
              ),
            ),
          );
        } else if (state is OnboardingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<OnboardingCubit>().loadCards();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}