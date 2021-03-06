import 'package:dayaway_partner/data/foundation/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(
      {required T data,
      @Default(0) int count,
      @Default(1) totalPage}) = Success<T>;

  const factory Result.failure({required AppError error}) = Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(data: body());
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }
  }

  static Future<Result<T>> guardFuture<T>(
    Future<T> Function() future,
  ) async {
    try {
      return Result.success(data: await future());
    } catch (e) {
      if (e is Exception) {
        return Result.failure(error: AppError(e));
      } else {
        return Result.failure(error: AppError(Exception(e.toString())));
      }
    }
  }

  bool get isSuccess =>
      when(success: (data, count, totalPage) => true, failure: (e) => false);

  bool get isFailure => !isSuccess;

  void ifSuccess(Function(T data) body) {
    maybeWhen(
      success: (data, count, totalPage) => body(data),
      orElse: () {
        // no-op
      },
    );
  }

  void ifFailure(Function(AppError e) body) {
    maybeWhen(
      failure: (e) => body(e),
      orElse: () {
        // no-op
      },
    );
  }

  T get dataOrThrow {
    return when(
      success: (data, count, totalPage) => data,
      failure: (e) => throw e,
    );
  }
}

extension ResultObjectExt<T> on T {
  Result<T> get asSuccess => Result.success(data: this);

  Result<T> asFailure(Exception e) => Result.failure(error: AppError(e));
}
