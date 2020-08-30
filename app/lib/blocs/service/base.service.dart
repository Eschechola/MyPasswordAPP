import 'dart:io';

import 'package:http/io_client.dart';

class BaseService{
  getHttpClient(){
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
    
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);
    
    IOClient client = new IOClient(httpClient);
    
    return client;
  }
}