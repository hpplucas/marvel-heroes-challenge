abstract class Failure {
  String? message;

  Failure({
    this.message,
  });
}

class LocalDatasourceFailure extends Failure {
  LocalDatasourceFailure({String? message}):super(message: message);
}