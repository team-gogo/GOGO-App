import 'package:gogo_app/data/data_sources/stage/stage_data_source.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/official_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/fast_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/stage_confirm_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:gogo_app/data/models/stage/search_information/search_game_format_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_query_string.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_response.dart';
import 'package:gogo_app/data/models/stage/community/community_write_request.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_temp_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_ranking_response.dart';
import 'package:gogo_app/data/models/stage/handle_stage/match_notice_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_maintainer_response.dart';
import 'package:gogo_app/data/models/stage/search_information/search_temp_point_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_point_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_team_response.dart';
import 'package:gogo_app/data/models/stage/community/community_like_response.dart';
import 'package:gogo_app/data/models/stage/community/community_comment_request.dart';

import '../../models/stage/community/sort_type.dart';
import '../../models/stage/enum_type/game_type.dart';
import '../../models/stage/handle_stage/join_stage_request.dart';
import 'stage_repository.dart';

class StageRepositoryImpl implements StageRepository {
  final StageDataSource _stageDataSource;

  StageRepositoryImpl(this._stageDataSource);

  @override
  Future<void> createFastStage(FastStageCreateRequest body) async {
    return await _stageDataSource.createFastStage(body);
  }

  @override
  Future<void> confirmStage(int stageId, StateConfirmRequest body) async {
    return await _stageDataSource.confirmStage(stageId, body);
  }

  @override
  Future<void> joinStage(int stageId, JoinStageRequest body) async {
    return await _stageDataSource.joinStage(stageId, body);
  }

  @override
  Future<void> applyTeam(int gameId, TeamApplyRequest body) async {
    return await _stageDataSource.applyTeam(gameId, body);
  }

  @override
  Future<SearchTeamResponse> getTeams(int gameId) async {
    return await _stageDataSource.getTeams(gameId);
  }

  @override
  Future<SearchTempTeamResponse> getTempTeams(int gameId) async {
    return await _stageDataSource.getTempTeams(gameId);
  }

  @override
  Future<SearchTeamInfoResponse> getTeamDetail(int teamId) async {
    return await _stageDataSource.getTeamDetail(teamId);
  }

  @override
  Future<SearchGameResponse> getGame(int stageId) async {
    return await _stageDataSource.getGame(stageId);
  }

  @override
  Future<SearchStageResponse> getAllStages() async {
    return await _stageDataSource.getAllStages();
  }

  @override
  Future<SearchMatchInfoResponse> searchMatchInfo(int matchId) async {
    return await _stageDataSource.searchMatchInfo(matchId);
  }

  @override
  Future<SearchMatchResponse> searchMatch(
      int stageId, int y, int m, int d) async {
    return await _stageDataSource.searchMatch(stageId, y, m, d);
  }

  @override
  Future<SearchRankingResponse> searchRanking(
      int stageId, int page, int size) async {
    return await _stageDataSource.searchRanking(stageId, page, size);
  }

  @override
  Future<MatchNoticeResponse> toggleMatchNotice(int matchId) async {
    return await _stageDataSource.toggleMatchNotice(matchId);
  }

  @override
  Future<void> createCommunityPost(
      int stageId, CommunityWriteRequest body) async {
    return await _stageDataSource.createCommunityPost(stageId, body);
  }

  @override
  Future<SearchBoardResponse> getCommunityPosts(int stageId, int page, int size,
      GameType? gameType, SortType? sortType) async {
    return await _stageDataSource.getCommunityPosts(
        stageId, page, size, gameType, sortType);
  }

  @override
  Future<SearchCommunityDetailResponse> getCommunityPostDetail(
      int boardId) async {
    return await _stageDataSource.getCommunityPostDetail(boardId);
  }

  @override
  Future<CommunityLikeResponse> likeCommunityPost(int boardId) async {
    return await _stageDataSource.likeCommunityPost(boardId);
  }

  @override
  Future<CommunityLikeResponse> createCommunityComment(
      int boardId, CommunityCommentRequest body) async {
    return await _stageDataSource.createCommunityComment(boardId, body);
  }

  @override
  Future<CommunityLikeResponse> likeCommunityComment(int commentId) async {
    return await _stageDataSource.likeCommunityComment(commentId);
  }

  @override
  Future<SearchMaintainerResponse> getMaintainer(int stageId) async {
    return await _stageDataSource.getMaintainer(stageId);
  }

  @override
  Future<SearchTempPointResponse> getTempPoint(int stageId) async {
    return await _stageDataSource.getTempPoint(stageId);
  }

  @override
  Future<SearchMyPointResponse> getMyPoint(int stageId) async {
    return await _stageDataSource.getMyPoint(stageId);
  }

  @override
  Future<SearchMyTeamResponse> getMyTeam() async {
    return await _stageDataSource.getMyTeam();
  }

  @override
  Future<SearchMatchResponse> getMyMatch(int stageId) async {
    return await _stageDataSource.getMyMatch(stageId);
  }

  @override
  Future<SearchGameFormatResponse> getGameFormat(int gameId) async {
    return await _stageDataSource.getGameFormat(gameId);
  }
}
