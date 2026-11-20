class ApiEndpoints {
  // Base configuration
  static const String baseUrl = 'https://api.sppg.example.com/api/v1';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Endpoints
  static const String homeDashboard = '/dashboard';
  static const String sppgList = '/sppg';
  static const String userProfile = '/user/profile';
  static const String notifications = '/notifications';
  static const String jadwal = '/jadwal';
  static const String cuti = '/cuti';
}
