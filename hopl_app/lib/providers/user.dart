import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  var _name;
  var _emailId;
  var _phoneNumber;
  var _orders;
  var _shopkeeper;
  var _address;
  var _imgUrl;
  var _createdAt;
  var _token;
  var _isAuth = false;

  set setToken(String token) {
    _token = token;
  }

  String get getToken {
    return _token;
  }

  set setIsAuth(bool isAuth) {
    _isAuth = isAuth;
  }

  bool get getBool {
    return _isAuth;
  }

  void LoginHandler(String emailId, String password) async {
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    print(domainUri);
    try {
      print("hii");
      var token = await client.post(Uri.parse("$domainUri/api/user/login"),
          body: json.encode({emailId: emailId, password: password}),
          headers: {"Content-Type": "application/json"});
      print("hii");
      // print(token);
    } catch (e) {
      print(e);
      client.close();
    }
  }

  set setUser(Map<String, Object> user) {
    _name = user["name"];
    _emailId = user["_emailId"];
    _phoneNumber = user["_phoneNumber"];
    _orders = user["_orders"];
    _shopkeeper = user["shopkeeper"];
    _address = user["address"];
    _imgUrl = user["imgUrl"];
    _createdAt = user["createdAt"];
  }
}
