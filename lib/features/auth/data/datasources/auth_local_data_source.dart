import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheSession(AuthSessionModel session);
  Future<AuthSessionModel?> getCachedSession();
  Future<void> clearSession();
}
