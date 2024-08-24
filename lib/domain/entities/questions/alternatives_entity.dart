class AlternativesEntity {
  final String letter;
  final String? text;
  final String? file;
  final bool isCorrect;

  AlternativesEntity({
    required this.letter,
    this.text,
    this.file,
    required this.isCorrect,
  });
}
