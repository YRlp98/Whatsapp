import 'package:connectivity/connectivity.dart';

Future<bool> checkConnectionInternet() async {
  var connectivityResult = await (new Connectivity().checkConnectivity());
  print(connectivityResult);
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}
