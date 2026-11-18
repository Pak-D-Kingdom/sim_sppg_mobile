import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_dashboard.dart';
import '../repositories/home_repository.dart';

class GetHomeDashboard implements UseCase<HomeDashboard, NoParams> {
  final HomeRepository repository;

  GetHomeDashboard(this.repository);

  @override
  Future<Either<Failure, HomeDashboard>> call(NoParams params) async {
    return await repository.getHomeDashboard();
  }
}
