
import 'package:objectbox/objectbox.dart';

@Entity()
class AlternativesEntity {
  @Id()
  int id;

  final String letter;
  final String? text;
  final String? file;
  final bool isCorrect;

  AlternativesEntity({
    this.id = 0,
    required this.letter,
    this.text,
    this.file,
    required this.isCorrect,
  });
}
