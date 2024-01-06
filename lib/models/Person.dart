import 'dart:convert';
import 'dart:math';

import 'package:MyInv_flutter/models/personsList.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Person {
  int _id = -1;
  String _email;
  String _pass;
  String _salt;
  static int _nbPersons = -1;
  static late final Dio dio = Dio(BaseOptions(receiveDataWhenStatusError: true,validateStatus: (status) { return status! < 500; },extra: {'withCredentials': true}));

  Person(this._email, this._pass, this._salt) {
    _nbPersons++;
    _id = _nbPersons;
  }

  int get id => _id;

  String get email => _email;

  String get pass => _pass;

  String get salt => _salt;

  void set id(int i) => _id = i;

  void set email(String s) => _email = s;

  void set pass(String s) => _pass = s;

  void set salt(String s) => _salt = s;

  /*static bool signUp(String em, String p, String confirmP) {
    if (p != confirmP) {
      return false;
    }
    else {

      if (em!=""&&p!=""&&confirmP!="") {
        try {
                String salt = _generateSalt();
                String hashedPass = hashPassword(p, salt);

                persons.add(Person(em, hashedPass, salt));
                return true;
              } catch (e) {
                return false;
              }
      } else {
          return false;
      }
    }
  }*/
  static Future<bool> signUp(String u,String em, String p, String confirmP) async {
    if(p!=confirmP){
      return false;
    }
    String url="";
    kIsWeb? url="http://localhost/MyInv/credentials/signup.php":url="http://10.0.2.2/MyInv/credentials/signup.php";
    var response;
    try {
      response = await dio.post(
        url,
        data: jsonEncode({
          'username': u,
          'email': em,
          'password': p,
          'repassword': confirmP,
        }),
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(response?.data);
      print(e);
    }
    return false;
  }

  static String _generateSalt() {
    // Generate a random salt, you can use a more sophisticated method
    // to create a stronger salt.
    return Random.secure().toString();
  }

  static String hashPassword(String password, String salt) {
    // Concatenate the password and salt before hashing
    String saltedPassword = password + salt;

    // Hash the salted password using SHA-256 algorithm
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);

    return hash.toString();
  }
  static Future<bool> login(String em, String pass) async {
    String url="";
    kIsWeb? url="http://localhost/MyInv/credentials/login.php":url="http://10.0.2.2/MyInv/credentials/login.php";
    try {
      var response = await dio.post(
        url,
        data: {
          'username': em,
          'password': pass,
        },
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  static Future<bool> logout() async {
    String url="";
    kIsWeb? url="http://localhost/MyInv/credentials/logout.php":url="http://10.0.2.2/MyInv/credentials/logout.php";
    try {
      var response = await dio.post(
        url,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}