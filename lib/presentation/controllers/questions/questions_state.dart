import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionsState extends Equatable{
  const QuestionsState();

  @override
  List<Object?> get props => [];
}

class InitialQuestionsState extends QuestionsState {}

class LoadingQuestionsState extends QuestionsState {}

class SuccessQuestionsState extends QuestionsState {
  final QuestionsEntity questions;

  const SuccessQuestionsState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class LoadingPaginationState extends QuestionsState {}

class SuccessPaginationState extends QuestionsState {
  final QuestionsEntity questions;

  const SuccessPaginationState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class FailureQuestionsState extends QuestionsState {
  final String msg;

  const FailureQuestionsState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class OfflineQuestionsState extends QuestionsState {}