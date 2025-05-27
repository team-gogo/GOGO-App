abstract class TeamCreateState {
  const TeamCreateState();
}

class TeamCreateInitialState extends TeamCreateState {
  const TeamCreateInitialState();
}

class TeamCreateLoadingState extends TeamCreateState {
  const TeamCreateLoadingState();
}

class TeamCreateSuccessState extends TeamCreateState {
  const TeamCreateSuccessState();
}

class TeamCreateFailureState extends TeamCreateState {
  final String errorMessage;

  const TeamCreateFailureState({
    required this.errorMessage,
  });
}
