import 'dart:convert';

import 'package:flutter_application_6/static_classes/user_informations.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
// import 'package:wms/static_classes/user_informations.dart';

class LogInUser {
  //final String host = '10.0.2.2';
  Future<void> _saveValue({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<Response> logInUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/login_employe');
    Map requestData = {
      'email': UserInformations.email,
      'password': UserInformations.password,
    };
    var response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 202 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      await _saveValue(key: 'token', value: data['token']);
      await _saveValue(key: 'place_type', value: data['place_type']);
      await _saveValue(key: 'place_id', value: data['place_id']);
      print('log in done successfully \n body=${response.body}');
      return response;
    } else {
      print(
        'log in failed \n statusCode=${response.statusCode} \n body=${response.body}',
      );
      return response;
    }
  }
}
