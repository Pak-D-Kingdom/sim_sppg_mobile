import 'package:equatable/equatable.dart';
import '../../domain/entities/riwayat_absen_data.dart';
import '../../domain/entities/riwayat_absen_item.dart';

abstract class RiwayatAbsenState extends Equatable {
  const RiwayatAbsenState();

  @override
  List<Object?> get props => [];
}

class RiwayatAbsenInitial extends RiwayatAbsenState {
  const RiwayatAbsenInitial();
}

class RiwayatAbsenLoading extends RiwayatAbsenState {
  const RiwayatAbsenLoading();
}

class RiwayatAbsenLoaded extends RiwayatAbsenState {
  static const int initialVisibleCount = 5;

  final RiwayatAbsenData data;
  final RiwayatFilterType selectedFilter;
  final bool showAll;
  final String? feedbackMessage;

  const RiwayatAbsenLoaded({
    required this.data,
    this.selectedFilter = RiwayatFilterType.semua,
    this.showAll = false,
    this.feedbackMessage,
  });

  List<RiwayatAbsenItem> get filteredItems =>
      data.items.where((item) => item.matchesFilter(selectedFilter)).toList();

  List<RiwayatAbsenItem> get visibleItems {
    final list = filteredItems;
    if (showAll || list.length <= initialVisibleCount) {
      return list;
    }
    return list.take(initialVisibleCount).toList();
  }

  RiwayatAbsenLoaded copyWith({
    RiwayatAbsenData? data,
    RiwayatFilterType? selectedFilter,
    bool? showAll,
    String? feedbackMessage,
    bool clearFeedback = false,
  }) {
    return RiwayatAbsenLoaded(
      data: data ?? this.data,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      showAll: showAll ?? this.showAll,
      feedbackMessage:
          clearFeedback ? null : (feedbackMessage ?? this.feedbackMessage),
    );
  }

  @override
  List<Object?> get props => [data, selectedFilter, showAll, feedbackMessage];
}

class RiwayatAbsenError extends RiwayatAbsenState {
  final String message;

  const RiwayatAbsenError(this.message);

  @override
  List<Object?> get props => [message];
}
