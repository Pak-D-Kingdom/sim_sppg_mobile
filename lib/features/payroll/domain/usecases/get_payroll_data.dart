import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payroll_data.dart';
import '../repositories/payroll_repository.dart';

class GetPayrollData {
  final PayrollRepository repository;

  GetPayrollData(this.repository);

  Future<Either<Failure, PayrollData>> call({int? year}) async {
    return await repository.getPayrollData(year: year);
  }
}
