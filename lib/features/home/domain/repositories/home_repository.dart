import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_dashboard.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDashboard>> getHomeDashboard();
}
