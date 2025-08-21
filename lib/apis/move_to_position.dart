import 'dart:convert';

import 'package:flutter_application_6/static_classes/move_to_position_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoveToPosition {
  String? _token;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
  }

  Future<void> moveToPositionMethod({
    required int containerId,
    required int postionID,
    required String why,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/move_to_position');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "container_id": containerId,
      "position_id": postionID,
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
        MoveToPositionData.moveToPositionMap = {};
        MoveToPositionData.moveToPositionMap.addAll(data);
        print('MoveToPosition sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent MoveToPosition Status code: ${response.statusCode}',
        );
        MoveToPositionData.moveToPositionMap = {};
        MoveToPositionData.moveToPositionMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in MoveToPosition: $e');
    }
  }
}
