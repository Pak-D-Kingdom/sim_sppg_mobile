import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/payroll_data.dart';
import '../../domain/repositories/payroll_repository.dart';
import '../datasources/payroll_remote_data_source.dart';

class PayrollRepositoryImpl implements PayrollRepository {
  final PayrollRemoteDataSource remoteDataSource;

  PayrollRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PayrollData>> getPayrollData({int? year}) async {
    try {
      final res = await remoteDataSource.getPayrollData(year: year);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
