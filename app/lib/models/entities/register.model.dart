class Register{
  String name;
  String email;
  String password;
  int type;

  String confirmPassword;
  bool remember = false;

  Register({this.name, this.email, this.password, this.type, this.confirmPassword, this.remember});
}