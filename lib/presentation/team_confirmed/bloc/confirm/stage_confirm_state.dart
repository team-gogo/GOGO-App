abstract class StageConfirmState {
  const StageConfirmState();
}

class StageConfirmInitial extends StageConfirmState {
  const StageConfirmInitial();
}

class StageConfirmLoading extends StageConfirmState {
  const StageConfirmLoading();
}

class StageConfirmSuccess extends StageConfirmState {
  const StageConfirmSuccess();
}

class StageConfirmFailure extends StageConfirmState {
  final String errorMessage;

  const StageConfirmFailure({
    required this.errorMessage,
  });
}
