import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<Map> sendDataToLogin(Map body) async {
    final response =
        await http.post('http://roocket.org/api/login', body: body);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
}
