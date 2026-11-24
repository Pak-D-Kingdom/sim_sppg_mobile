import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_session_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthSessionModel> login({
    required String identifier,
    required String password,
    required bool rememberMe,
  }) async {
    final trimmedId = identifier.trim();
    final trimmedPassword = password.trim();

    if (trimmedId.isEmpty) {
      throw const ServerException(
        message: 'ID Personel atau email tidak boleh kosong.',
      );
    }

    if (trimmedPassword.length < 6) {
      throw const ServerException(
        message: 'Kata sandi minimal 6 karakter.',
      );
    }

    return AuthSessionModel(
      personnelId: trimmedId.contains('@') ? 'SPPG-RMG-014' : trimmedId,
      fullName: 'Siti Rahmawati, A.Md.Gz',
      email: trimmedId.contains('@')
          ? trimmedId
          : 'siti.rahmawati@sppg.go.id',
      accessToken: 'sppg_mock_token_${DateTime.now().millisecondsSinceEpoch}',
      rememberMe: rememberMe,
    );
  }
}
