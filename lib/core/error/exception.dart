import 'package:dio/dio.dart';

class Failure {
  final String? errorMessage;

  String get message => errorMessage ?? '';

  Failure({
    this.errorMessage,
  });

  @override
  String toString() {
    if (message.isNotEmpty) {
      return message;
    } else {
      return "Something went wrong, Please try again";
    }
  }
}

class UnknownException extends Failure {
  final String? errMessage;
  UnknownException([this.errMessage]) : super(errorMessage: errMessage);

  @override
  String toString() {
    if ((errMessage ?? '').isNotEmpty) {
      return message;
    } else {
      return "Something went wrong, Please try again";
    }
  }
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return Failure(
        errorMessage: error.message ??
            "Error connecting to the server\nplease try again later",
      );
    } else if (error is NoInternetException) {
      return Failure(
        errorMessage: "It seems you're not connected to the internet",
      );
    } else if (error is Exception) {
      return Failure(errorMessage: error.toString());
    } else {
      return Failure(
        errorMessage: "An unexpected error occurred",
      );
    }
  }
}

class NoInternetException implements Exception {}
