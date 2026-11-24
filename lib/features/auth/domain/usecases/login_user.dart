import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, AuthSession>> call(LoginUserParams params) {
    return repository.login(
      identifier: params.identifier,
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }
}

class LoginUserParams extends Equatable {
  final String identifier;
  final String password;
  final bool rememberMe;

  const LoginUserParams({
    required this.identifier,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [identifier, password, rememberMe];
}
