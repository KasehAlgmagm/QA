import 'dart:convert';

import 'package:flutter_application_6/static_classes/show_container_movements_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowContainerMovements {
  String? _token;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
  }

  Future<void> showContainerMovementsMethod({required int containerId}) async {
    var url = Uri.parse(
      'http://10.0.2.2:8000/api/show_continer_movments/$containerId',
    );

    await _fetchData();

    try {
      final response = await get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      Map<dynamic, dynamic> data = json.decode(response.body);
      if (response.statusCode == 202 || response.statusCode == 201) {
        ShowContainerMovementsData.showContainerMovementsMap.addAll(data);

        print('ShowContainerMovements sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent ShowContainerMovements Status code: ${response.statusCode}',
        );
        ShowContainerMovementsData.showContainerMovementsMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in ShowContainerMovements: $e');
    }
  }
}
