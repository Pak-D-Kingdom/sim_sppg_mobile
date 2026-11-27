import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/auth_session_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String cachedAuthSessionKey = 'CACHED_AUTH_SESSION';

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheSession(AuthSessionModel session) async {
    try {
      // shortcut: token stored in SharedPreferences, migrate to flutter_secure_storage before production
      final saved = await sharedPreferences.setString(
        cachedAuthSessionKey,
        jsonEncode(session.toJson()),
      );
      if (!saved) {
        throw const CacheException(message: 'Gagal menyimpan sesi autentikasi.');
      }
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(message: 'Gagal menyimpan sesi autentikasi: $e');
    }
  }

  @override
  Future<AuthSessionModel?> getCachedSession() async {
    final jsonString = sharedPreferences.getString(cachedAuthSessionKey);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        await sharedPreferences.remove(cachedAuthSessionKey);
        throw const CacheException(message: 'Format sesi lokal tidak valid.');
      }
      return AuthSessionModel.fromJson(decoded);
    } on CacheException {
      rethrow;
    } catch (e) {
      await sharedPreferences.remove(cachedAuthSessionKey);
      throw CacheException(message: 'Gagal membaca sesi autentikasi: $e');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await sharedPreferences.remove(cachedAuthSessionKey);
    } catch (e) {
      throw CacheException(message: 'Gagal menghapus sesi autentikasi: $e');
    }
  }
}
