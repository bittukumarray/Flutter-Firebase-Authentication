import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../model/user.dart';
import '../page/home.dart';

class UserModel extends Model {
  Login _UserDetails;

  Login get UserDetails {
    return _UserDetails;
  }

  Future<Map<String, dynamic>> UserLogin(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyA_W339N6Y48EdfoF99so0hdFqQxbbsrrI',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication Succeeded';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'The email is invalid';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The Password is invalid';
    }

    return {'hasError': hasError, 'message': message};
  }

  void CreateUser(String name, String email, String phone) async {
    final Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "phone": phone,
    };

    await http.post('https://fluuter-login.firebaseio.com/NewUsers.json',
        body: json.encode(userData));
    notifyListeners();
  }

  Future<Map<String, dynamic>> Signin(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyA_W339N6Y48EdfoF99so0hdFqQxbbsrrI',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication Succeeded';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] ==
        'WEAK_PASSWORD : Password should be at least 6 characters') {
      message = 'Password should be at least 6 characters.';
    }

    return {'hasError': hasError, 'message': message};
  }
}
