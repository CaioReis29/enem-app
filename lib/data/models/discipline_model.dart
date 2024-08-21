import 'package:enem_app/domain/entities/discipline_entity.dart';

class DisciplineModel extends DisciplineEntity {
  DisciplineModel({required super.label, required super.value});
  
  factory DisciplineModel.fromJson(Map<String, dynamic> json) {
    return DisciplineModel(
      label: json["label"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
