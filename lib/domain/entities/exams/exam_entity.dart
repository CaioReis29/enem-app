import 'package:enem_app/domain/entities/exams/discipline_entity.dart';
import 'package:enem_app/domain/entities/exams/language_entity.dart';
import 'package:equatable/equatable.dart';

class ExamEntity extends Equatable{
  final String title;
  final int year;
  final List<DisciplineEntity> disciplines;
  final List<LanguageEntity> languages;

  const ExamEntity({
    required this.title,
    required this.year,
    required this.disciplines,
    required this.languages,
  });
  
  @override
  List<Object?> get props => [
    title,
    year,
    disciplines,
    languages,
  ];
}
