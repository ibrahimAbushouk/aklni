import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/home/ui/screen/home_screen.dart';
import '../../../features/onboarding/data/remote_data_sources/onboarding_local_dataSource.dart';
import '../../../features/onboarding/data/repo_implementation/onboarding_repositoryImpl.dart';
import '../../../features/onboarding/domain/use_cases/get_cardsUseCase.dart';
import '../../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../../constants/PrefKeys.dart';
import '../../utils/helper/shared_pref_helper.dart';
import '../app_routes/app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.onBoardingScreen,
    redirect: (context, state) {
      try {
        bool hasSeenOnboarding =
            SharedPrefHelper.instance.getBool(PrefKeys.onboardingSeen) ?? false;

        if (!hasSeenOnboarding &&
            state.uri.toString() != AppRoutes.onBoardingScreen) {
          return AppRoutes.onBoardingScreen;
        }

        if (hasSeenOnboarding &&
            state.uri.toString() == AppRoutes.onBoardingScreen) {
          return AppRoutes.homeScreen;
        }

        return null;
      } catch (e) {
        // في حالة عدم التهيئة
        return AppRoutes.onBoardingScreen;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        name: AppRoutes.onBoardingScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => OnboardingCubit(
            GetCardsUseCase(
              OnboardingRepositoryImpl(
                OnboardingLocalDataSourceImpl(),
              ),
            ),
          )..loadCards(),
          child: const OnBoardingScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
