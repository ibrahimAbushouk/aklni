import '../../../../core/constants/PrefKeys.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/helper/shared_pref_helper.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getOnboardingSeen();
  Future<void> setOnboardingSeen(bool seen);
  Future<void> clearOnboardingSeen();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  @override
  Future<bool> getOnboardingSeen() async {
    try {
      return await SharedPrefHelper.getBoolWithDefault(
        PrefKeys.onboardingSeen,
        false,
      );
    } catch (e) {
      throw CacheFailure('Failed to get onboarding status: $e');
    }
  }

  @override
  Future<void> setOnboardingSeen(bool seen) async {
    try {
      await SharedPrefHelper.setData(PrefKeys.onboardingSeen, seen);
    } catch (e) {
      throw CacheFailure('Failed to set onboarding status: $e');
    }
  }

  @override
  Future<void> clearOnboardingSeen() async {
    try {
      await SharedPrefHelper.removeData(PrefKeys.onboardingSeen);
    } catch (e) {
      throw CacheFailure('Failed to clear onboarding status: $e');
    }
  }
}