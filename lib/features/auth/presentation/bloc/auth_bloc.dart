import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;

  AuthBloc({required this.loginUser}) : super(const AuthInitial()) {
    on<SubmitLoginEvent>(_onSubmitLogin);
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
}
