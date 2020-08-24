import 'package:mypassword/models/entities/base.model.dart';

class Customer extends Base{
  int id;
  String name;
  String email;
  String password;
  int type;

  String token;
  String tokenExpireDate;
  
  Customer({this.id = 0, this.name, this.email, this.password, this.type, this.token = "", this.tokenExpireDate = ""});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  String toJson() => 
    "{" +
      "\"id\": 0,"+
      "\"name\": \"${name}\","+
      "\"email\": \"${email.trimRight().trimLeft()}\","+
      "\"password\": \"${password}\","+
      "\"type\": ${type}"+
    "}";

    Map<String, dynamic> toMap() => {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
      'tokenExpireDate': tokenExpireDate
    };
}