import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> getOnboardingSeen();
  Future<Either<Failure, void>> setOnboardingSeen(bool seen);
  Future<Either<Failure, void>> clearOnboardingSeen();
}