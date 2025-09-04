import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repo_interface/settings_onboarding_repository.dart';

class SetOnboardingSeenUseCase {
  final SettingsRepository settingsRepository;

  SetOnboardingSeenUseCase(this.settingsRepository);

  Future<Either<Failure, void>> call(bool seen) async {
    return await settingsRepository.setOnboardingSeen(seen);
  }
}