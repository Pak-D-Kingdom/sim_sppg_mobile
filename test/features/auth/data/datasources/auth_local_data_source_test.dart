import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_sppg_mobile/core/error/exceptions.dart';
import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import 'package:sim_sppg_mobile/core/usecase/usecase.dart';
import 'package:sim_sppg_mobile/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:sim_sppg_mobile/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:sim_sppg_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:sim_sppg_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sim_sppg_mobile/features/auth/domain/usecases/get_cached_session.dart';
import 'package:sim_sppg_mobile/features/auth/domain/usecases/login_user.dart';
import 'package:sim_sppg_mobile/features/auth/domain/usecases/logout_user.dart';
import 'package:sim_sppg_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sim_sppg_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:sim_sppg_mobile/features/auth/presentation/bloc/auth_state.dart';

void main() {
  late SharedPreferences prefs;
  late AuthLocalDataSourceImpl localDataSource;
  late AuthRepositoryImpl repository;

  const sampleSession = AuthSessionModel(
    personnelId: 'SPPG-RMG-014',
    fullName: 'Siti Rahmawati, A.Md.Gz',
    email: 'siti.rahmawati@sppg.go.id',
    accessToken: 'token-123',
    rememberMe: true,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    localDataSource = AuthLocalDataSourceImpl(sharedPreferences: prefs);
    repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(dioClient: DioClient()),
      localDataSource: localDataSource,
    );
  });

  group('AuthLocalDataSourceImpl', () {
    test('returns null when no session is cached', () async {
      expect(await localDataSource.getCachedSession(), isNull);
    });

    test('caches and restores AuthSessionModel', () async {
      await localDataSource.cacheSession(sampleSession);
      expect(await localDataSource.getCachedSession(), equals(sampleSession));
    });

    test('clears cached session', () async {
      await localDataSource.cacheSession(sampleSession);
      await localDataSource.clearSession();
      expect(await localDataSource.getCachedSession(), isNull);
    });

    test('clears corrupt json and throws CacheException', () async {
      await prefs.setString(
        AuthLocalDataSourceImpl.cachedAuthSessionKey,
        '{invalid-json',
      );
      await expectLater(
        localDataSource.getCachedSession(),
        throwsA(isA<CacheException>()),
      );
      expect(
        prefs.getString(AuthLocalDataSourceImpl.cachedAuthSessionKey),
        isNull,
      );
    });
  });

  group('AuthRepositoryImpl & AuthBloc persistence', () {
    test('caches session when rememberMe is true and clears when false',
        () async {
      final loginTrue = await repository.login(
        identifier: 'SPPG-RMG-014',
        password: 'password123',
        rememberMe: true,
      );
      expect(loginTrue.isRight(), isTrue);
      expect(await localDataSource.getCachedSession(), isNotNull);

      final loginFalse = await repository.login(
        identifier: 'SPPG-RMG-014',
        password: 'password123',
        rememberMe: false,
      );
      expect(loginFalse.isRight(), isTrue);
      expect(await localDataSource.getCachedSession(), isNull);
    });

    test('AuthBloc restores cached session and clears it on LogoutEvent',
        () async {
      await localDataSource.cacheSession(sampleSession);
      final bloc = AuthBloc(
        loginUser: LoginUser(repository),
        getCachedSession: GetCachedSession(repository),
        logoutUser: LogoutUser(repository),
      );
      addTearDown(bloc.close);

      bloc.add(const CheckAuthStatusEvent());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const AuthLoading(),
          const AuthAuthenticated(session: sampleSession),
        ]),
      );

      bloc.add(const LogoutEvent());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const AuthLoading(),
          const AuthUnauthenticated(),
        ]),
      );

      final cachedAfterLogout = await GetCachedSession(repository)(const NoParams());
      expect(cachedAfterLogout.getOrElse(() => sampleSession), isNull);
    });
  });
}
