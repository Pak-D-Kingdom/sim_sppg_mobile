import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/akun_profile.dart';

abstract class AkunRepository {
  Future<Either<Failure, AkunProfile>> getAkunProfile();
}
