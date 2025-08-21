import 'dart:convert';

import 'package:flutter_application_6/static_classes/show_sections_on_place_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSectionsOnPlace {
  String? _token;
  String? _placeID;
  String? _placeType;
  Future<String?> _getValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _fetchData() async {
    _token = await _getValue(key: 'token');
    _placeID = await _getValue(key: 'place_id');
    _placeType = await _getValue(key: 'place_type');
  }

  Future<void> showSectionsOnPlaceMethod() async {
    await _fetchData();
    var url = Uri.parse(
      'http://10.0.2.2:8000/api/show_sections_on_place/$_placeType/$_placeID',
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
        ShowSectionsOnPlaceData.showSectionsOnPlaceMap = {};
        ShowSectionsOnPlaceData.showSectionsOnPlaceMap.addAll(data);

        print('ShowSectionsOnPlace sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent ShowSectionsOnPlace Status code: ${response.statusCode}',
        );
        ShowSectionsOnPlaceData.showSectionsOnPlaceMap = {};
        ShowSectionsOnPlaceData.showSectionsOnPlaceMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in ShowSectionsOnPlace: $e');
    }
  }
}
