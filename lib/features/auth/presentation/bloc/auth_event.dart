import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SubmitLoginEvent extends AuthEvent {
  final String identifier;
  final String password;
  final bool rememberMe;

  const SubmitLoginEvent({
    required this.identifier,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [identifier, password, rememberMe];
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
