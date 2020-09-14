import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:fireauth/services/auth/imageJson.dart';
import 'package:http_parser/http_parser.dart';
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
import 'package:dio/dio.dart';

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
var postUrl = "http://tradetalkies.herokuapp.com/post";
var likeUrl = "http://tradetalkies.herokuapp.com/like";
var commentUrl = "http://tradetalkies.herokuapp.com/comment";
var repostUrl = "http://tradetalkies.herokuapp.com/repost";
var feedUrl = "http://tradetalkies.herokuapp.com/feed";

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
    prefs.setString('USER_IMAGE',
        "https://tradetalkies.s3.ap-south-1.amazonaws.com/profileImg/1598811137375_129b421f-1786-47b1-95eb-ff68e4e7f3b4_pimg.jpg");
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
    String fileName = basename(image.path);
    print("filebase name is $fileName");
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      String newToken = await firebaseMessaging.getToken();
      //     4444444444444444444444444444444444444444444444444
      // print(image.readAsBytesSync());
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
      // var multipartFile = new http.MultipartFile('imageUrl', stream, length,
      // filename: basename(image.path));
      // request.files.add(multipartFile);
      // print(multipartFile.toString());
      // print(uri);
      // print(length);
      // print(request);
      // var response = await request.send();
      // print(response.statusCode);
      // response.stream.transform(utf8.decoder).listen((event) {
      // print(event);
      // });

      // // print(image);
      // print(image.path);
      // print(image.toString());
      // print(image.absolute);
      // print(image.readAsString(encoding: ));

      FormData formData = new FormData.fromMap({
        "email": email,
        "age": age,
        "industry": industry,
        // "images": await http.MultipartFile.fromPath(fileName,image.path   ,contentType:),
        "images": await MultipartFile.fromFile(image.path.toString(),
            filename: fileName, contentType: MediaType("image", "jpg")),

        "firebaseToken": newToken,
      });

      Dio dio = new Dio();
      dio.options.headers["content-type"] = "multipart/form-data";
      dio.options.headers["authorization"] = "Bearer $_token";
      dio.options.headers["cookie"] = "$_token";

      Response response = await dio.post(edit_profile, data: formData);
      print("File response ${response}");

      // final response = await http.post(edit_profile,
      //     headers: {
      //       "Content-type": "application/json",
      //       "Cookie": "$_token",
      //       HttpHeaders.authorizationHeader: "Bearer $_token",
      //     },
      //     body: json.encode(
      //       {
      //         "email": email,
      //         "age": age,
      //         "industry": industry,
      //         "image": base64Image,
      //         "firebaseToken": newToken,
      //       },
      //     ));
      // print("ab = ${newToken}");
      // print(_token);
      // print(response.body);
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
      String imageUrl = json.decode(response.body)['currentuser']['imageUrl'];
      String decodeIndustry =
          json.decode(response.body)['currentuser']['industry'];
      Map output = {
        'age': decodeAge,
        'industry': decodeIndustry,
        'image': imageUrl,
        'userName': _name
      };
      // print(output['age']);
      // print(output['industry']);
      print('vvhv');
      print(response.body);

      print(output);
      print(imageUrl);

      return output;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<List> getData() async {
    try {
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/all-tickers",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      // int decodeAge = json.decode(response.body)['currentuser']['age'];
      // String imageUrl = json.decode(response.body)['currentuser']['imageUrl'];
      // String decodeIndustry =
      //     json.decode(response.body)['currentuser']['industry'];
      // Map output = {'age': decodeAge, 'industry': decodeIndustry,'image':imageUrl,'userName':_name};
      // print(output['age']);
      // print(output['industry']);
      // print('vvhv');
      // print(response.body);
      List data = json.decode(response.body);
      // print('data is $data');
      return data;

      // print(output);
      // print(imageUrl);

      // return output;
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

  Future<String> post(
      String desc,
      // List stocks,
      List images,
      List pickers) async {
    try {
      // if(images.length==)
      // String fileName = basename(images[0].path);
      // String fileName1 = basename(images[1].path);

      // final ext = extension(images[0].path).replaceAll('.', '');
      // print(ext);

      FormData formData;
      print(images.length);
      if (images[0] == 'one') {
        formData = new FormData.fromMap({
          "desc": desc,
          "tickers": pickers,
        });
      } else if (images.length == 1) {
        formData = new FormData.fromMap({
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 2) {
        formData = new FormData.fromMap({
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 3) {
        formData = new FormData.fromMap({
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "image3": await MultipartFile.fromFile(images[2].path.toString(),
              filename: basename(images[2].path),
              contentType: MediaType(
                  "image", extension(images[2].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 4) {
        formData = new FormData.fromMap({
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "image3": await MultipartFile.fromFile(images[2].path.toString(),
              filename: basename(images[2].path),
              contentType: MediaType(
                  "image", extension(images[2].path).replaceAll('.', ''))),
          "image4": await MultipartFile.fromFile(images[3].path.toString(),
              filename: basename(images[3].path),
              contentType: MediaType(
                  "image", extension(images[3].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      }

      print(formData);

      // print("filebase name is $fileName");
      // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();4
      // String newToken = await firebaseMessaging.getToken();

      // FormData formData = new FormData.fromMap({4444
      //   "desc": desc,
      //   // "images": await http.MultipartFile.fromPath(fileName,image.path   ,contentType:),

      //   // for (int i = 0;i<images.length; i++){
      //     // "image$i": await MultipartFile.fromFile(images[i].path.toString(),
      //         // filename: basename(images[i].path), contentType: MediaType("image", "jpg")),

      //     "image1": await MultipartFile.fromFile(images[0].path.toString(),
      //         filename: fileName, contentType: MediaType("image", "jpg")),
      //   "image2": await MultipartFile.fromFile(images[1].path.toString(),
      //       filename: fileName1, contentType: MediaType("image", ext)),

      //   // "firebaseToken": newToken,
      // });

      Dio dio = new Dio();
      dio.options.headers["content-type"] = "multipart/form-data";
      dio.options.headers["authorization"] = "Bearer $_token";
      dio.options.headers["cookie"] = "$_token";

      Response response = await dio.post(postUrl, data: formData);
      print("File response ${response}");
      print(response.data.runtimeType);
      String id = response.data['post']['_id'];

      // imageFiles[0] = await MultipartFile.fromFile(imageFiles[0].path.toString(),
      //     filename: fileName, contentType: MediaType("image", "jpg"));
      // print(imageFiles);
      // imageFiles[1] = await MultipartFile.fromFile(imageFiles[1].path.toString(),
      //     filename: fileName1, contentType: MediaType("image", "jpg"));
      // print(imageFiles);

      // final response = await http.post(4
      //   postUrl,
      //   headers: {
      //     "Content-type": "application/json",
      //     "Cookie": "$_token",
      //     HttpHeaders.authorizationHeader: "Bearer $_token",
      //   },
      //   body: json.encode(
      //     {
      //       "desc": desc,
      //       "images": images,
      //     },
      //   ),
      // );

      // print(response);

      notifyListeners();
      return id;
      // setLoginPrefs(decodeEmail, decodeUsername, headerToken, decodeUserId);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<String> repost(
      String desc,
      // List stocks,
      List images,
      List pickers,
      String postId) async {
    try {
      // if(images.length==)
      // String fileName = basename(images[0].path);
      // String fileName1 = basename(images[1].path);

      // final ext = extension(images[0].path).replaceAll('.', '');
      // print(ext);

      FormData formData;
      print(images.length);
      if (images[0] == 'one') {
        formData = new FormData.fromMap({
          "repostId": postId,
          "desc": desc,
          "tickers": pickers,
        });
      } else if (images.length == 1) {
        formData = new FormData.fromMap({
          "repostId": postId,
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 2) {
        formData = new FormData.fromMap({
          "repostId": postId,
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 3) {
        formData = new FormData.fromMap({
          "repostId": postId,
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "image3": await MultipartFile.fromFile(images[2].path.toString(),
              filename: basename(images[2].path),
              contentType: MediaType(
                  "image", extension(images[2].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      } else if (images.length == 4) {
        formData = new FormData.fromMap({
          "repostId": postId,
          "desc": desc,
          "image1": await MultipartFile.fromFile(images[0].path.toString(),
              filename: basename(images[0].path),
              contentType: MediaType(
                  "image", extension(images[0].path).replaceAll('.', ''))),
          "image2": await MultipartFile.fromFile(images[1].path.toString(),
              filename: basename(images[1].path),
              contentType: MediaType(
                  "image", extension(images[1].path).replaceAll('.', ''))),
          "image3": await MultipartFile.fromFile(images[2].path.toString(),
              filename: basename(images[2].path),
              contentType: MediaType(
                  "image", extension(images[2].path).replaceAll('.', ''))),
          "image4": await MultipartFile.fromFile(images[3].path.toString(),
              filename: basename(images[3].path),
              contentType: MediaType(
                  "image", extension(images[3].path).replaceAll('.', ''))),
          "tickers": pickers,
        });
      }

      print(formData);

      // print("filebase name is $fileName");
      // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();4
      // String newToken = await firebaseMessaging.getToken();

      // FormData formData = new FormData.fromMap({4444
      //   "desc": desc,
      //   // "images": await http.MultipartFile.fromPath(fileName,image.path   ,contentType:),

      //   // for (int i = 0;i<images.length; i++){
      //     // "image$i": await MultipartFile.fromFile(images[i].path.toString(),
      //         // filename: basename(images[i].path), contentType: MediaType("image", "jpg")),

      //     "image1": await MultipartFile.fromFile(images[0].path.toString(),
      //         filename: fileName, contentType: MediaType("image", "jpg")),
      //   "image2": await MultipartFile.fromFile(images[1].path.toString(),
      //       filename: fileName1, contentType: MediaType("image", ext)),

      //   // "firebaseToken": newToken,
      // });

      Dio dio = new Dio();
      dio.options.headers["content-type"] = "multipart/form-data";
      dio.options.headers["authorization"] = "Bearer $_token";
      dio.options.headers["cookie"] = "$_token";

      Response response = await dio.post(repostUrl, data: formData);
      print("File response ${response}");
      print(response.data.runtimeType);
      String id = response.data['post']['_id'];
      // String id = 'see json for id';

      // imageFiles[0] = await MultipartFile.fromFile(imageFiles[0].path.toString(),
      //     filename: fileName, contentType: MediaType("image", "jpg"));
      // print(imageFiles);
      // imageFiles[1] = await MultipartFile.fromFile(imageFiles[1].path.toString(),
      //     filename: fileName1, contentType: MediaType("image", "jpg"));
      // print(imageFiles);

      // final response = await http.post(4
      //   postUrl,
      //   headers: {
      //     "Content-type": "application/json",
      //     "Cookie": "$_token",
      //     HttpHeaders.authorizationHeader: "Bearer $_token",
      //   },
      //   body: json.encode(
      //     {
      //       "desc": desc,
      //       "images": images,
      //     },
      //   ),
      // );

      // print(response);

      notifyListeners();
      return id;
      // setLoginPrefs(decodeEmail, decodeUsername, headerToken, decodeUserId);
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
      print('1');
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      print('2');

      String newToken = await firebaseMessaging.getToken();
      print('3');

      // google login methods...
      GoogleSignIn _googleSignIn = GoogleSignIn();
      print('4');

      _googleSignIn.disconnect();
      print('5');

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      print('6');

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print('7');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print('8');

      AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      print('1');

      final FirebaseUser firebseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
      print('1');

      if (FirebaseUser != null) {
        print('yes');
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
      print('jj');
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
  Future<void> like(
    String id,
  ) async {
    try {
      // String cid="5f4632eb2225433c38b718f6";
      final response = await http.post(
        likeUrl,
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        body: json.encode(
          {
            "postId": id,
          },
        ),
      );

      print(response.body);

      notifyListeners();
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> comment(String text, String id) async {
    try {
      print("id is $id");
      final response = await http.post(
        commentUrl,
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        body: json.encode(
          {"postId": id, "comment": text},
        ),
      );

      print(response.body);

      notifyListeners();
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<List> getcomment(String id) async {
    try {
      print("id is $id");
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/post/$id/comments",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );

      // print(response.body);

      List comments = json.decode(response.body)['comments'];
      // print(comments);
      print(comments[0]['comment']);
      print(comments[0]['postedBy']['local']['username']);
      print(comments[0]['postedBy']['createdAt']);
      // print(DateTime(comments[0]['createdAt']));
      print(comments[0]['postedBy']['imageUrl']);
      // Map output = {

      //   'image': '',
      //   'userName': '_name'
      // };

      notifyListeners();
      return comments;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> feed(DateTime date) async {
    try {
      // print("id is $id");
      print('shs');
      print(date.toIso8601String());
      final response = await http.get(
        "http://tradetalkies.herokuapp.com/feed?startTimestamp=${date}",
        headers: {
          "Content-type": "application/json",
          "Cookie": "$_token",
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        
      );

      print(response.body);

      notifyListeners();
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
