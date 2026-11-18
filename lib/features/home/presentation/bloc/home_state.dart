import 'package:equatable/equatable.dart';
import '../../domain/entities/home_dashboard.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeDashboard dashboard;

  const HomeLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
