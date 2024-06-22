import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:info_app/core/error/exception.dart';
import 'package:info_app/core/shared/usecases/network_info.dart';
import 'package:info_app/locator.dart';


Future<Either<String, T>> executeAndHandleError<T>(
  Future<T> Function() function,
) async {
  try {
    // final internet = await locator<NetworkChecker>().isConnected;
    // if (!internet) throw NoInternetException();
    final result = await function();
    return Right(result);
  } catch (e, s) {
    print('Exception in executeAndHandleError$e');
    print('Stack trace in executeAndHandleError$s');
    final failure = ErrorHandler.handle(e);
    return Left(failure.errorMessage ?? "");
  }
}

Future<T> executeAndHandleErrorServer<T>(
  Future<T> Function() function,
) async {
  try {
    // final internet = await locator<NetworkChecker>().isConnected;
    // if (!internet) throw NoInternetException();
    final result = await function();
    return result;
  } on DioException catch (error) {
    if (error.response?.statusCode == 401) {
      // homeKey.currentState?.pushNamed('/login');
    }
    print(error.response?.data);
    throw DioException(
        message: error.response?.data?["error_status"].toString(),
        requestOptions: error.requestOptions);
  } on NoInternetException {
    throw NoInternetException();
  } on Exception catch (error, s) {
    print('Exception in executeAndHandleError$error');
    print('Stack trace in executeAndHandleError$s');
    throw Exception(error.toString());
  }
}
