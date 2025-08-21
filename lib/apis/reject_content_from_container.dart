import 'dart:convert';

import 'package:flutter_application_6/static_classes/reject_content_from_container_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RejectContentFromContainer {
  String? _token;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
  }

  Future<void> rejectContentFromContainerMethod({
    required int contentId,
    required String why,
    required int quantity,
  }) async {
    var url = Uri.parse(
      'http://10.0.2.2:8000/api/reject_content_from_continer',
    );

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "content_id": "$contentId",
      "why": why,
      "quantity": "$quantity",
    };
    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(requestData),
      );
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      Map<dynamic, dynamic> data = json.decode(response.body);

      if (response.statusCode == 202 || response.statusCode == 201) {
        RejectContentFromContainerData.rejectContentFromContainerMap = {};
        RejectContentFromContainerData.rejectContentFromContainerMap.addAll(
          data,
        );

        print(' RejectContentFromContainer sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent  RejectContentFromContainer Status code: ${response.statusCode}',
        );
        RejectContentFromContainerData.rejectContentFromContainerMap = {};
        RejectContentFromContainerData.rejectContentFromContainerMap.addAll(
          data,
        );
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in  RejectContentFromContainer: $e');
    }
  }
}
