import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_akun_profile.dart';
import 'akun_event.dart';
import 'akun_state.dart';

class AkunBloc extends Bloc<AkunEvent, AkunState> {
  final GetAkunProfile getAkunProfile;

  AkunBloc({required this.getAkunProfile}) : super(const AkunInitial()) {
    on<LoadAkunProfileEvent>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
    LoadAkunProfileEvent event,
    Emitter<AkunState> emit,
  ) async {
    emit(const AkunLoading());
    final result = await getAkunProfile();
    result.fold(
      (failure) => emit(AkunError(failure.message)),
      (profile) => emit(AkunLoaded(profile: profile)),
    );
  }
}
