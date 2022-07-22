import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class PrefsService {
  static final String _token = 'token';

  static save(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _token,
      jsonEncode({"token": token, "isAtuth": true}),
    );
  }

   static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_token);
       if (jsonResult != null) {
      var mapMat = jsonDecode(jsonResult);
      return mapMat['isAuth'];
    }

    return false;
  }
}
