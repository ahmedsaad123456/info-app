import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker {
  final InternetConnectionChecker connectionChecker;

  NetworkChecker(this.connectionChecker);
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
