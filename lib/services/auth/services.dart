import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../http_exception.dart';

var baseUrl = DotEnv().env['BASE_URL'];

var sing_in = "http://tradetalkies.herokuapp.com/login";
var sign_up = "http://tradetalkies.herokuapp.com/local-signin";
var password_reset = "http://tradetalkies.herokuapp.com/passwordreset";
var fb_sign_in = 'http://tradetalkies.herokuapp.com/android-facebook-login';
var google_sign_in = "http://tradetalkies.herokuapp.com/android-google-login";
var edit_profile = "http://tradetalkies.herokuapp.com/edit-profile";
var user = "http://tradetalkies.herokuapp.com/user";
var change_Password = "http://tradetalkies.herokuapp.com/change-password";

var signUp = "$baseUrl/signup";
var signIn = "$baseUrl/auth/login";

Map<String, String> headers = {"Content-type": "application/json"};

class UserAuth with ChangeNotifier {
  String _name;
  String _email;
  String _token;
  String _userId;

  Map<String, String> headers = {
    "Content-type": "application/json",
  };
  Map<String, String> headers1 = {
    "Cookie":
        "connect.sid=s%3A2d9SfTD0wJWODKCnI7NpzxPqXYjDD2iA.zrM230nDfyi%2FLWORi%2BlTp62guJ18d2%2BcpquI4xY1W4w"
  };

  Future<void> init() async {
    loadLoginPrefs();
    notifyListeners();
  }

  // getting the token from getter of token after varifying all conditions...
  bool get isAuth {
    if (_token != null) {
      return true;
    }
    print("no token found till now...");
    return false;
  }

  Future<bool> isSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._token = prefs.getString('USER_TOKEN') ?? null;
    if (_token != null) {
      return true;
    }
    return false;
  }

  // get username in another files...
  String get name {
    return _name;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get token {
    return _token;
  }

  setLoginPrefs(String e, String n, String t, String i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('USER_EMAIL', e);
    prefs.setString('USER_NAME', n);
    prefs.setString('USER_TOKEN', t);
    prefs.setString('USER_ID', i);
  }

  loadLoginPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._token = prefs.getString('USER_TOKEN') ?? null;
    this._email = prefs.getString('USER_EMAIL') ?? null;
    this._name = prefs.getString('USER_NAME') ?? null;
    this._userId = prefs.getString('USER_ID') ?? null;
    print(_token);
    print(_userId);
  }

  Future<void> signup(
    String email,
    String password,
    String userName,
  ) async {
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();

      final response = await http.post(
        sign_up,
        headers: headers,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "username": userName,
            "firebaseToken": newToken,
          },
        ),
      );

      print(response.body);
      String decodeUserId = json.decode(response.body)['user']['_id'];
      String decodeEmail = json.decode(response.body)['user']['local']['email'];
      String decodeUsername =
          json.decode(response.body)['user']['local']['username'];
      print(decodeUserId);
      print(decodeUsername);
      print(decodeEmail);
      String headerToken = response.headers['set-cookie'].split(';').first;
      print(response.headers);
      notifyListeners();
      setLoginPrefs(decodeEmail, decodeUsername, headerToken, decodeUserId);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> change_password(
    String oldPassword,
    String password,
  ) async {
    try {
      // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      // String newToken = await firebaseMessaging.getToken();

      final response = await http.post(
        change_Password,
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        body: json.encode(
          {
            "password": password,
            "oldPassword": oldPassword,

          },
        ),
      );

      print(response.body);
      // String decodeUserId = json.decode(response.body)['user']['_id'];
      // String decodeEmail = json.decode(response.body)['user']['local']['email'];
      // String decodeUsername =
      // json.decode(response.body)['user']['local']['username'];
      // print(decodeUserId);
      // print(decodeUsername);
      // print(decodeEmail);
      // String headerToken = response.headers['set-cookie'].split(';').first;
      // print(response.headers);
      notifyListeners();
      // setLoginPrefs(decodeEmail, decodeUsername, headerToken, decodeUserId);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> editProfile(
    // String industry,
    String age,
    String industry,
    File image,
  ) async {
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();

      // String base64Image = base64Encode(image.readAsBytesSync());
      // print(image);
      // print(base64Image);
      // File image1 = base64Decode(base64Image) as File;
      // print(image1);\

      // var stream = new http.ByteStream(image.openRead());
      // stream.cast();

      // var length = await image.length();
      // var uri = Uri.parse(edit_profile);
      // var request = new http.MultipartRequest("POST", uri);
      // var multipartFile = new http.MultipartFile('file_field', stream, length,
      //     filename: basename(image.path));
      // request.files.add(multipartFile);
      // print(multipartFile);
      // print(uri);
      // print(length);
      // print(request);
      // var response = await request.send();
      // print(response.statusCode);
      // response.stream.transform(utf8.decoder).listen((event) {
      //   print(event);
      // });

      // // print(image);
      final response = await http.post(
        edit_profile,
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        body: json.encode(
          {
            "email": email,
            "age": age,
            "industry": industry,
            "firebaseToken": newToken,
          },
        ),
      );
      // print("ab = ${newToken}");
      print(_token);
      print(response.body);
      // String headerToken = response.headers['set-cookie'].split(';').first;
      // print(response.headers);
      // print(headerToken);
      notifyListeners();
      // setLoginPrefs(_email, _name, headerToken);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> getInfo(
      // String industry,
      // String age,
      // String industry,
      ) async {
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/user/$_userId",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      int decodeAge = json.decode(response.body)['currentuser']['age'];
      String decodeIndustry =
          json.decode(response.body)['currentuser']['industry'];

      // final response = await http.post(
      //   edit_profile,
      //   headers: {
      //     "Content-type": "application/json",
      //     "Cookie": "$_token",
      //     HttpHeaders.authorizationHeader: "Bearer $_token",
      //   },
      //   body: json.encode(
      //     {
      //       "email": email,
      //       "age": age,
      //       "industry": industry,
      //       "firebaseToken": newToken,
      //     },
      //   ),
      // );
      // print("ab = ${newToken}");
      print(_token);
      print(response.body);
      print(_userId);
      print(decodeAge);
      print(decodeIndustry);
      // return decodeage;
      // String headerToken = response.headers['set-cookie'].split(';').first;
      // print(response.headers);
      // print(headerToken);
      // notifyListeners();
      // setLoginPrefs(_email, _name, headerToken);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<Map> getAge() async {
    try {
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/user/$_userId",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      int decodeAge = json.decode(response.body)['currentuser']['age'];
      String decodeIndustry =
          json.decode(response.body)['currentuser']['industry'];
      Map output = {'age': decodeAge, 'industry': decodeIndustry};
      // print(output['age']);
      // print(output['industry']);
      print('vvhv');

      print(output);

      return output;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<String> getIndustry() async {
    try {
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/user/$_userId",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      String decodeIndustry =
          json.decode(response.body)['currentuser']['industry'];

      print(decodeIndustry);

      return decodeIndustry;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> getResetdata() async {
    try {
      final response = await http.get(
        password_reset + ':sarthbhat@gmail.com',
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      print(response.body);
      // String decodeIndustry =
      //     json.decode(response.body)['currentuser']['industry'];

      // print(decodeIndustry);

      // return decodeIndustry;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      // firebase token generating....
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();
      // applying fb login
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email', 'public_profile']);
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
      final profile = json.decode(graphResponse.body);

      final response = await http.post(
        fb_sign_in,
        headers: headers,
        body: json.encode(
          {
            'userName': profile['name'],
            'email': profile['email'],
            'uid': profile['id'],
            'firebaseToken': newToken,
          },
        ),
      );
      String decodeUserId = json.decode(response.body)['user']['_id'];
      print(response.headers['set-cookie']);
      String headerToken = response.headers['set-cookie'].split(';').first;
      notifyListeners();
      setLoginPrefs(
          profile['email'], profile['name'], headerToken, decodeUserId);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // firebase token generating....
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();

      // google login methods...
      GoogleSignIn _googleSignIn = GoogleSignIn();
      _googleSignIn.disconnect();
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final FirebaseUser firebseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (FirebaseUser != null) {
        final response = await http.post(
          google_sign_in,
          headers: headers,
          body: json.encode(
            {
              'userName': firebseUser.displayName,
              'email': firebseUser.email,
              'uid': firebseUser.uid,
              'firebaseToken': newToken,
            },
          ),
        );

        String headerToken = response.headers['set-cookie'].split(';').first;
        notifyListeners();
        setLoginPrefs(firebseUser.email, firebseUser.displayName, headerToken,
            firebseUser.providerId);
      } else {
        print("its error");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> signin(String email, String password) async {
    print("coming from sign in func...");
    // firebase token generating....
    FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
    String newToken = await firebaseMessaging.getToken();
    try {
      final response = await http.post(
        "http://tradetalkies.herokuapp.com/login",
        headers: headers,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'firebaseToken': newToken,
          },
        ),
      );

      if (response.statusCode >= 400) {
        String err = json.decode(response.body)['errorMessage'];
        throw HttpException(err);
      }
      String decodeEmail = json.decode(response.body)['user']['local']['email'];
      String decodeUsername =
          json.decode(response.body)['user']['local']['username'];
      String decodeUserId = json.decode(response.body)['user']['_id'];

      String headerToken = response.headers['set-cookie'].split(';').first;
      notifyListeners();
      setLoginPrefs(decodeEmail, decodeUsername, headerToken, decodeUserId);
    } catch (err) {
      throw err;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await http.post(
        password_reset,
        headers: headers,
        body: json.encode(
          {
            'email': email,
          },
        ),
      );

      print(response.body);

      if (response.statusCode >= 400) {
        String err = json.decode(response.body)['errorMessage'];
        throw HttpException(err);
      }

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('USER_TOKEN')) {
      return false;
    }
    _token = prefs.getString('USER_TOKEN');
    print("coming from auto login....");
    print(_token);
    loadLoginPrefs();
    notifyListeners();
    return true;
  }

  // logout functanility
  Future<void> logout() async {
    print("logging out");
    _token = null;
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // autologout if the expiry time has crossed......
  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}