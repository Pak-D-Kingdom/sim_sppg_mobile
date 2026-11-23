import '../models/payroll_data_model.dart';

abstract class PayrollRemoteDataSource {
  Future<PayrollDataModel> getPayrollData({int? year});
}
