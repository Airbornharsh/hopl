import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/userDetails.dart';
import 'package:hopl_app/providers/order.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  late UserDetails _userDetail = UserDetails(
      name: "name",
      emailId: "emailId",
      phoneNumber: 7837489789,
      orders: [],
      shopkeeper: false,
      address: "address",
      imgUrl:
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
      createdAt: "createdAt",
      token: "token",
      isAuth: false);
  // var _name;
  // var _emailId;
  // var _phoneNumber;
  // var _orders;
  // var _shopkeeper;
  // var _address;
  // var _imgUrl;
  // var _createdAt;
  // var _isAuth = false;
  // var _token;
  var _otpAccessToken;
  var _shopkeeperActive = false;

  set setToken(String token) {
    _userDetail.token = token;
  }

  String get getToken {
    return _userDetail.token;
  }

  void setIsAuth(bool isAuth) {
    _userDetail.isAuth = isAuth;
    notifyListeners();
  }

  bool get getAuth {
    return _userDetail.isAuth;
  }

  get getShopkeeperActive {
    return _shopkeeperActive;
  }

  void setShopkeeperActive(bool data) {
    _shopkeeperActive = data;
  }

  UserDetails get getDetails {
    // UserDetails details = UserDetails(
    //     name: _name,
    //     emailId: _emailId,
    //     phoneNumber: _phoneNumber,
    //     orders: _orders,
    //     shopkeeper: _shopkeeper,
    //     address: _address,
    //     imgUrl: _imgUrl,
    //     createdAt: _createdAt,
    //     token: _token,
    //     isAuth: _isAuth);

    return _userDetail;
  }

  Future<bool> LoginHandler(String emailId, String password) async {
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var tokenRes = await client.post(Uri.parse("$domainUri/api/user/login"),
          body: json.encode({
            "emailId": "harshkeshri123456@gmail.com",
            "password": "password"
          }),
          // body: json.encode({"emailId": emailId, "password": password}),
          headers: {"Content-Type": "application/json"});

      if (tokenRes.statusCode != 200) {
        throw tokenRes.body;
      }
      var parsedBody = json.decode(tokenRes.body);
      prefs.setString("hopl_accessToken", parsedBody["accessToken"]);
      _userDetail.token = parsedBody["accessToken"];
      _userDetail.isAuth = true;
      var userRes = await client.get(
          Uri.parse("$domainUri/api/logged-user/profile"),
          headers: {"authorization": "Bearer hopl ${_userDetail.token}"});
      var parsedUserBody = json.decode(userRes.body);

      _userDetail = UserDetails(
          name: parsedUserBody["name"].isNotEmpty
              ? parsedUserBody["name"]
              : "harsh",
          emailId: parsedUserBody["emailId"].isNotEmpty
              ? parsedUserBody["emailId"]
              : "emailId",
          phoneNumber: parsedUserBody["phoneNumber"],
          orders: parsedUserBody["orders"].isNotEmpty
              ? parsedUserBody["orders"]
              : [],
          shopkeeper: parsedUserBody["shopkeeper"],
          address: parsedUserBody["address"].isNotEmpty
              ? parsedUserBody["address"]
              : "address",
          imgUrl: parsedUserBody["imgUrl"],
          createdAt: parsedUserBody["createdAt"].isNotEmpty
              ? parsedUserBody["createdAt"]
              : "emailId",
          token: _userDetail.token,
          isAuth: true);

      // _name = parsedUserBody["name"];
      // _phoneNumber = parsedUserBody["phoneNumber"];
      // _emailId = parsedUserBody["emailId"];
      // _orders = parsedUserBody["orders"];
      // _address = parsedUserBody["address"];
      // _createdAt = parsedUserBody["createdAt"];
      // _imgUrl = parsedUserBody["imgUrl"];
      // _shopkeeper = parsedUserBody["shopkeeper"];

      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
  }

  Future<bool> RegisterHandler(
    String name,
    int phoneNumber,
    String emailId,
    String password,
    String confirmPasssword,
  ) async {
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var Res = await client.post(Uri.parse("$domainUri/api/user/register"),
          body: json.encode({
            "name": name,
            "phoneNumber": phoneNumber,
            "emailId": emailId,
            "password": password
          }),
          headers: {"Content-Type": "application/json"});
      if (Res.statusCode != 200) {
        return false;
      }
      var parsedBody = json.decode(Res.body);
      _otpAccessToken = parsedBody["accessToken"];
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
  }

  Future<bool> CodeHandler(String code) async {
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var res = await client.post(
          Uri.parse("$domainUri/api/user/register/verify"),
          body: json.encode({"accessToken": _otpAccessToken, "otp": code}),
          headers: {"Content-Type": "application/json"});
      if (res.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
  }

  set setUser(Map<String, Object> user) {
    _userDetail = UserDetails(
        name: user["name"] as String,
        emailId: user["emailId"] as String,
        phoneNumber: user["phoneNumber"] as int,
        orders: user["orders"] as List<dynamic>,
        shopkeeper: user["shopkeeper"] as bool,
        address: user["address"] as String,
        imgUrl: user["imgUrl"] as String,
        createdAt: user["createdAt"] as String,
        token: _userDetail.token,
        isAuth: _userDetail.isAuth);
  }
}
