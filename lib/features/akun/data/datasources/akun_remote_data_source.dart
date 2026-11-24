import '../models/akun_profile_model.dart';

abstract class AkunRemoteDataSource {
  Future<AkunProfileModel> getAkunProfile();
}
