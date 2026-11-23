import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payroll_data.dart';

abstract class PayrollRepository {
  Future<Either<Failure, PayrollData>> getPayrollData({int? year});
}
