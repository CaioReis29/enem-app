import 'package:enem_app/core/exceptions/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class Usecase<R, P> {
  Future<Result<R, Failure>> call(P parameter);
}

class GetQuestionsParams {
  final String year;
  final int? limit;
  final int? offset;
  final String? language;

  GetQuestionsParams({
    required this.year,
    this.limit,
    this.offset,
    this.language,
  });
}


class NoParameter{}