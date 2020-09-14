import 'package:mypassword/blocs/service/base.service.dart';
import 'package:http/http.dart' as http;
import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/settings/settings.dart';

class PasswordService extends BaseService {
  dynamic _client;

  PasswordService(){
    _client = getHttpClient();
  }

  Future<http.Response> getAllPasswords(int id, String token) async{
    var url = "${Settings.API_URL}/password/get-all/${id}";

    final response = await _client.get(
        url,
        headers: getDefaultHeadersWithToken(token)
    );

    return response;
  }

  Future<http.Response> insertPassword(Password password, String token) async {
    var url = "${Settings.API_URL}/password/insert";
    var body = password.toJson();
    
    final response = _client.post(
      url,
      headers: getDefaultHeadersWithToken(token),
      body: body
    );

    return response;
  }

  Future<http.Response> deletePassword(int id, String token) async{
    var url = "${Settings.API_URL}/password/delete/${id}";
    
    final response = _client.delete(
      url,
      headers: getDefaultHeadersWithToken(token)
    );

    return response;
  }
}