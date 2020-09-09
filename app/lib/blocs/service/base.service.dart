import 'dart:io';

import 'package:http/io_client.dart';

class BaseService{
  IOClient getHttpClient(){
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
    
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);
    
    IOClient client = new IOClient(httpClient);
    
    return client;
  }

  Object getDefaultHeaders(){
    return {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  Object getDefaultHeadersWithToken(String token){
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };
  }
}