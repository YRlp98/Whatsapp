class User {
  int id;
  String apiToken;

  User.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    apiToken = parsedJson['api_toekn'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'api_token': apiToken,
    };
  }
}
