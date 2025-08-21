import 'dart:convert';

import 'package:flutter_application_6/static_classes/show_sections_of_container_in_place_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSectionsOfContainerInPlace {
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

  Future<void> showSectionsOfContainerInPlaceMethod({
    required int containerId,
  }) async {
    await _fetchData();
    var url = Uri.parse(
      'http://10.0.2.2:8000/api/show_sections_of_continer_in_place/$_placeType/$_placeID/$containerId',
    );

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
        ShowSectionsOfContainerInPlaceData.showSectionsOfContainerInPlaceMap =
            {};
        ShowSectionsOfContainerInPlaceData.showSectionsOfContainerInPlaceMap
            .addAll(data);

        print(
          'ShowSectionsOfContainerInPlace sent successfully:${response.body}',
        );
      } else {
        print(
          'Failed to sent ShowSectionsOfContainerInPlace Status code: ${response.statusCode}',
        );
        ShowSectionsOfContainerInPlaceData.showSectionsOfContainerInPlaceMap =
            {};
        ShowSectionsOfContainerInPlaceData.showSectionsOfContainerInPlaceMap
            .addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in ShowSectionsOfContainerInPlace: $e');
    }
  }
}
