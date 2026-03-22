import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/PrefKeys.dart';
import '../../../../core/routing/app_routes/app_routes.dart';
import '../../../../core/utils/helper/shared_pref_helper.dart';
import '../../domain/use_cases/get_cardsUseCase.dart';
import 'onboarding_state.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  final GetCardsUseCase getCardsUseCase;

  OnboardingCubit(this.getCardsUseCase) : super(OnboardingInitial());

  void loadCards() {
    try {
      final result = getCardsUseCase();
      emit(OnboardingLoaded(result));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  // ✅ دالة بسيطة للانتهاء
  Future<void> finishOnboarding(BuildContext context) async {
    try {
      await SharedPrefHelper.setData(PrefKeys.onboardingSeen, true);
      if (context.mounted) {
        GoRouter.of(context).pushReplacementNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      emit(OnboardingError('Failed to save onboarding status'));
    }
  }
}