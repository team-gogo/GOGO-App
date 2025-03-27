import 'package:gogo_app/data/models/stage/community/community_search_request_query_string.dart';

abstract class CommunityEvent {}

class FetchCommunityEvent extends CommunityEvent {
  final CommunitySearchRequestQueryString queryString;

  FetchCommunityEvent({required this.queryString});
}
