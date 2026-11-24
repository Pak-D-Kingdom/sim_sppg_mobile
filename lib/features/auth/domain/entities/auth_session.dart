import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String personnelId;
  final String fullName;
  final String email;
  final String accessToken;
  final bool rememberMe;

  const AuthSession({
    required this.personnelId,
    required this.fullName,
    required this.email,
    required this.accessToken,
    this.rememberMe = true,
  });

  @override
  List<Object?> get props => [
        personnelId,
        fullName,
        email,
        accessToken,
        rememberMe,
      ];
}
