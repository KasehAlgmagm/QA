import 'dart:convert';

import 'package:flutter_application_6/my_widget/filter_enum.dart';
import 'package:flutter_application_6/static_classes/search_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search {
  String? _token;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
  }

  Future<void> searchMethod({
    required FilterEnum filter,
    required String value,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/serch');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "filter": filter.name,
      "value": value,
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
        SearchData.searchMap.addAll(data);
        print('Search sent successfully:${response.body}');
      } else {
        print('Failed to sent Search Status code: ${response.statusCode}');
        SearchData.searchMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in Search: $e');
    }
  }
}
