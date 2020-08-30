import 'package:mypassword/blocs/service/base.service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mypassword/settings/settings.dart';

class PasswordService extends BaseService {
  dynamic _client;

  PasswordService(){
    _client = getHttpClient();
  }

  Future<http.Response> getAllPasswords(int id, String token) async{
    var url = "${Settings.API_URL}/password/get-all/${id}";

    final response = await _client.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${token}'
        }
    );

    return response;
  }
}