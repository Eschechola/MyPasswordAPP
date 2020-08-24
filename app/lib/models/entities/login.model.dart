class Login{
  String email;
  String password;
  bool remember;

  Login({this.email, this.password, this.remember});

  String toJson() => 
    "{" +
      "\"email\": \"${email.trimRight().trimLeft()}\", " +
      "\"password\": \"${password}\"" +
    "}";
}