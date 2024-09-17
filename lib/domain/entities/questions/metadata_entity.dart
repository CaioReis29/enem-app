import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MetadataEntity {
  @Id()
  int id;
  final int limit;
  final int offset;
  final int total;
  final bool hasMore;

  final relation = ToOne<QuestionsEntity>();

  MetadataEntity({
    this.id = 0,
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasMore,
  });
}
