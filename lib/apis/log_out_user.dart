import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutUser {
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void logOutUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/logout_employe');
    String? token = await _getValue(key: 'token');
    var response = await get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 202 || response.statusCode == 201) {
      print('log out done successfully \n body=${response.body}');
    } else {
      print(
        'log out failed \n statusCode=${response.statusCode} \n body=${response.body}',
      );
    }
  }
}
