import 'package:equatable/equatable.dart';

import '../../../data/models/stage/search_stage/search_ranking_response.dart';

enum RankingStatus {
  initial,
  loading,
  loaded,
  error,
}

class RankingState extends Equatable {
  RankingState({
    this.status = RankingStatus.initial,
    this.rank = const [],
    this.hasReachedMax = false,
  });

  final RankingStatus status;
  final List<Rank> rank;
  final bool hasReachedMax;

  RankingState copyWith({
    RankingStatus? status,
    List<Rank>? rank,
    bool? hasReachedMax,
  }) {
    return RankingState(
      status: status ?? this.status,
      rank: rank ?? this.rank,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [];
}
