import 'dart:io';

import 'package:mypassword/models/entities/customer.model.dart';
import 'package:http/http.dart' as http;
import 'package:mypassword/settings/settings.dart';

import 'baseHttp.service.dart';

class CustomerService extends BaseHttp{
  Future<http.Response> registerCustomer(Customer customer) async {
    var client = getHttpClient();
    var url = "${Settings.API_URL}/api/customer/insert";
    
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          //HttpHeaders.authorizationHeader: '',      
        },
        body: customer.toJson()
    );

    return response;
  }
}
