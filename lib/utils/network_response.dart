sealed class NetworkResponse<T> {}

class Success<T> extends NetworkResponse {
  T? data;

  Success({required this.data});
}

class Failure<T> extends NetworkResponse {
  Exception error;

  Failure({required this.error});
}
