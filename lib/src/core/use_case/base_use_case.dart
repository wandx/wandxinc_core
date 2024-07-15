import 'package:dartz/dartz.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

/// BaseUseCase is an abstract class that defines the structure of a use case
abstract class BaseUseCase<O, I> {
  /// Call method is the method that will be called to execute the use case
  Future<Either<BaseException, O>> call(I params);
}
