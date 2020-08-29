// import 'package:shared_preferences/shared_preferences.dart';

// // setting the prefrences....
// // email, name, phone, address, token, userId, expirydate
// setLoginPrefs(
//     String e, String n, String p, String t, String id, DateTime exp) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   prefs.setString('USER_EMAIL', e);
//   prefs.setString('USER_NAME', n);
//   prefs.setString('USER_PHONE', p);
//   prefs.setString('USER_TOKEN', t);
//   prefs.setString('USER_ID', id);
//   prefs.setString('USER_EXP', exp.toIso8601String());

//   print(DateTime.parse(prefs.getString('USER_EXP')));
// }

// loadLoginPrefs() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   this._email = prefs.getString('USER_EMAIL') ?? null;
//   this._name = prefs.getString('USER_NAME') ?? null;
//   this._phoneNo = prefs.getString('USER_PHONE') ?? null;
//   this._token = prefs.getString('USER_TOKEN') ?? null;
//   this._userId = prefs.getString('USER_ID') ?? null;
//   this._expiryDate = DateTime.parse(prefs.getString('USER_EXP')) ?? null;
// }
