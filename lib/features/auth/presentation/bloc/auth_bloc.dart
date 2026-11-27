import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_cached_session.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final GetCachedSession getCachedSession;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.getCachedSession,
    required this.logoutUser,
  }) : super(const AuthInitial()) {
    on<SubmitLoginEvent>(_onSubmitLogin);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onSubmitLogin(
    SubmitLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await loginUser(
      LoginUserParams(
        identifier: event.identifier,
        password: event.password,
        rememberMe: event.rememberMe,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (session) => emit(AuthAuthenticated(session: session)),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await getCachedSession(const NoParams());
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (session) => session != null
          ? emit(AuthAuthenticated(session: session))
          : emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await logoutUser(const NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}
