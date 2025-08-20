import 'dart:convert';

import 'package:flutter_application_6/static_classes/reject_container_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RejectContainer {
  String? _token;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
  }

  Future<void> rejectContainerMethod({
    required int containerID,
    required String why,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/reject_continer');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "continer_id": "$containerID",
      "why": why,
    };
    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(requestData),
      );
      Map<dynamic, dynamic> data = json.decode(response.body);
      if (response.statusCode == 202 || response.statusCode == 201) {
        RejectContainerData.rejectContainerMap.addAll(data);
        print('RejectContainer sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent RejectContainer Status code: ${response.statusCode}',
        );
        RejectContainerData.rejectContainerMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in RejectContainer: $e');
    }
  }
}
