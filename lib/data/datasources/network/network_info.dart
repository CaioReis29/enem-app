
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  late InternetConnection internetChecker;

  NetworkInfoImpl({required this.internetChecker});

  @override
  Future<bool> get isConnected async => await internetChecker.hasInternetAccess;
  
}