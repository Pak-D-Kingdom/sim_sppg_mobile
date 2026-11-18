import '../models/home_dashboard_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDashboardModel> getHomeDashboard();
}
