import 'package:enem_app/core/exeptions/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class Usecase<R, P> {
  Future<Result<R, Failure>> call(P parameter);
}

class NoParameter{}