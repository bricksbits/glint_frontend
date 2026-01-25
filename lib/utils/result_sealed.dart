sealed class Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(Exception error) = Failure<T>;
}

class Success<T> implements Result<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> implements Result<T> {
  final Exception error;
  final String? message;

  const Failure(this.error, {this.message = "Something went wrong,"});
}
