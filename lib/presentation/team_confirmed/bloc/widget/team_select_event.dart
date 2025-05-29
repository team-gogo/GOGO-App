import 'package:equatable/equatable.dart';

abstract class TeamSelectEvent extends Equatable {
  const TeamSelectEvent();

  @override
  List<Object> get props => [];
}

class ToggleTeamSelection extends TeamSelectEvent {
  final int teamId;

  const ToggleTeamSelection(this.teamId);

  @override
  List<Object> get props => [teamId];
}
