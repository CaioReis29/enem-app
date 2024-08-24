import 'package:enem_app/domain/entities/questions/metadata_entity.dart';

class MetadataModel extends MetadataEntity {
  MetadataModel({
    required super.limit,
    required super.offset,
    required super.total,
    required super.hasMore,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      limit: json["limit"],
      offset: json["offset"],
      total: json["total"],
      hasMore: json["hasMore"],
    );
  }

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "total": total,
        "hasMore": hasMore,
      };
}