import 'dart:io';

import 'package:mypassword/models/entities/customer.model.dart';
import 'package:http/http.dart' as http;
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/settings/settings.dart';

import 'base.service.dart';

class CustomerService extends BaseService{
  dynamic _client;

  CustomerService(){
    _client = getHttpClient();
  }

  Future<http.Response> insertCustomer(Customer customer) async {
    var url = "${Settings.API_URL}/customer/insert";
    
    final response = await _client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: customer.toJson()
    );

    return response;
  }

  Future<http.Response> loginCustomer(Login loginCustomer) async {
    var url = "${Settings.API_URL}/auth/login";

    print(loginCustomer.toJson());

    final response = await _client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: loginCustomer.toJson()
    );

    return response;
  }
}
