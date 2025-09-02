import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repo_interface/settings_onboarding_repository.dart';

class GetOnboardingSeenUseCase {
  final SettingsRepository settingsRepository;

  GetOnboardingSeenUseCase(this.settingsRepository);

  Future<Either<Failure, bool>> call() async {
    return await settingsRepository.getOnboardingSeen();
  }
}