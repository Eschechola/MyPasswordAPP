import 'customer.model.dart';

class Password {
  int id;
  int customerId;
  String title;
  String value;

  Customer customer;

  Password({this.id, this.customerId, this.title, this.value});

  Password.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    title = json['title'];
    value = json['value'];
  }

  String toJson() =>
    "{" +
      "\"id\": ${id != 0 ? id : 0},"+
      "\"customerId\": ${customerId},"+
      "\"title\": \"${title.trimRight().trimLeft()}\","+
      "\"value\": \"${value}\""+
    "}";
}

