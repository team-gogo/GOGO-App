import 'package:equatable/equatable.dart';

class TeamSelectState extends Equatable {
  final Set<int> selectedTeamIds;

  const TeamSelectState({this.selectedTeamIds = const {}});

  TeamSelectState copyWith({Set<int>? selectedTeamIds}) {
    return TeamSelectState(
      selectedTeamIds: selectedTeamIds ?? this.selectedTeamIds,
    );
  }

  @override
  List<Object> get props => [selectedTeamIds];
}
