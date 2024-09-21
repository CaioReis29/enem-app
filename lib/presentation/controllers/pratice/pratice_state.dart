import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PraticeState extends Equatable{
  const PraticeState();

  @override
  List<Object?> get props => [];
}

class InitialPraticeState extends PraticeState {}

class LoadingPraticeState extends PraticeState {}

class LoadedQuestionState extends PraticeState {
  final QuestionsEntity questions;

  const LoadedQuestionState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class LoadingPaginationState extends PraticeState {}

class NextQuestionState extends PraticeState {
  final QuestionsEntity questions;

  const NextQuestionState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class FailurePraticeState extends PraticeState {
  final String msg;

  const FailurePraticeState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class OfflinePraticeState extends PraticeState {}