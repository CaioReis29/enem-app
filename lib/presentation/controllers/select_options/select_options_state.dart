import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SelectOptionsState extends Equatable{
  const SelectOptionsState();

  @override
  List<Object?> get props => [];
}

class InitialSelectOptionsState extends SelectOptionsState {}

class LoadingSelectOptionsState extends SelectOptionsState {}

class SuccessSelectOptionsState extends SelectOptionsState {
  final List<ExamEntity> exams;

  const SuccessSelectOptionsState({required this.exams});

  @override
  List<Object?> get props => [exams];
}

class FailureSelectOptionsState extends SelectOptionsState {
  final String msg;

  const FailureSelectOptionsState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class OfflineSelectOptionsState extends SelectOptionsState {}