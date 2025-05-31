import 'package:equatable/equatable.dart';

import '../../../data/models/stage/search_stage/search_ranking_response.dart';

abstract class RankingState {}

class InitRanking extends RankingState{}

class LoadedRanking extends RankingState {}

class ErrorRanking extends RankingState {}
