import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repo_interface/settings_onboarding_repository.dart';
import '../remote_data_sources/onboarding_local_dataSource.dart';
import '../remote_data_sources/settings_onboarding_localdatasource.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, bool>> getOnboardingSeen() async {
    try {
      final result = await localDataSource.getOnboardingSeen();
      return Right(result);
    } catch (e) {
      if (e is CacheFailure) {
        return Left(e);
      }
      return Left(UnknownFailure('Unknown error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> setOnboardingSeen(bool seen) async {
    try {
      await localDataSource.setOnboardingSeen(seen);
      return const Right(null);
    } catch (e) {
      if (e is CacheFailure) {
        return Left(e);
      }
      return Left(UnknownFailure('Unknown error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearOnboardingSeen() async {
    try {
      await localDataSource.clearOnboardingSeen();
      return const Right(null);
    } catch (e) {
      if (e is CacheFailure) {
        return Left(e);
      }
      return Left(UnknownFailure('Unknown error: $e'));
    }
  }
}