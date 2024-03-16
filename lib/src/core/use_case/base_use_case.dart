import 'package:dartz/dartz.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

abstract class BaseUseCase<O, I> {
  Future<Either<BaseException, O>> call(I params);
}
