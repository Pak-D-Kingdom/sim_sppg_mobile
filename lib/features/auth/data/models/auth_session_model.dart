import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.personnelId,
    required super.fullName,
    required super.email,
    required super.accessToken,
    super.rememberMe,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      personnelId: json['personnel_id']?.toString() ?? 'SPPG-RMG-014',
      fullName: json['full_name']?.toString() ?? 'Siti Rahmawati, A.Md.Gz',
      email: json['email']?.toString() ?? 'siti.rahmawati@sppg.go.id',
      accessToken: json['access_token']?.toString() ?? '',
      rememberMe: json['remember_me'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personnel_id': personnelId,
      'full_name': fullName,
      'email': email,
      'access_token': accessToken,
      'remember_me': rememberMe,
    };
  }
}
