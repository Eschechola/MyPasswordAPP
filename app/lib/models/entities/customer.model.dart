import 'package:mypassword/models/entities/base.model.dart';

class Customer extends Base{
  String name;
  String email;
  String password;
  String confirmPassword;
  int type;
  
  Customer({this.name, this.email, this.password, this.type, this.confirmPassword});

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
      "\"email\": \"${email}\","+
      "\"password\": \"${password}\","+
      "\"type\": ${type}"+
    "}";

    Map<String, dynamic> toMap() => {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type
    };
}