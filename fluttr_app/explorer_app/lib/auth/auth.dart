import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<String> attemptLogIn(String id, String password) async {
  GlobalConfiguration cfg =
      await GlobalConfiguration().loadFromAsset("api_settings");
  var res = await http.post("${cfg.getValue("graphql_api_url")}v1/login",
      body: {"id": id, "password": password});
  if (res.statusCode == 200) {
    final storage = new FlutterSecureStorage();
    print(res.body);
    final jwt = json.decode(res.body);
    storage.write(key: "jwt", value: jwt["token"]);
    storage.write(key: "jwt_expire", value: jwt["expire"]);
    return res.body;
  }
  return null;
}

class JWTClient extends http.BaseClient {
  final String bearer;
  final http.Client _inner;

  JWTClient(this.bearer, this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = "Bearer $bearer";
    return _inner.send(request);
  }
}
