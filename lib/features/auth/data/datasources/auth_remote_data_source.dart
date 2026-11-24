import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String identifier,
    required String password,
    required bool rememberMe,
  });
}
