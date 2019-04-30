import 'package:flutter/material.dart';

class Signup {
  String name;
  String email;
  String phone;

  Signup({@required this.name, @required this.email, @required this.phone});
}

class Login {
  String email;
  String password;

  Login({@required this.email, @required this.password});
}
