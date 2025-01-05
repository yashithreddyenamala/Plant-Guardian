import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddPlantService {
  static const String baseUrl = "http://213.210.21.159:5000/api";

  static Future<Map<String, dynamic>> addPlant({
    required String name,
    required String type,
    required String wateringSchedule,
    required String fertilizingSchedule,
    required String sunlightRequirement,
    required String specialCare,
    required String purchaseDate,
    required String reminderTime,
    required File photo,
  }) async {
    final Uri url = Uri.parse('$baseUrl/plants/add');

    try {
      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        return {'success': false, 'message': 'User is not authenticated.'};
      }

      // Prepare multipart request
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = name
        ..fields['type'] = type
        ..fields['wateringSchedule'] = wateringSchedule
        ..fields['fertilizingSchedule'] = fertilizingSchedule
        ..fields['sunlightRequirement'] = sunlightRequirement
        ..fields['specialCare'] = specialCare
        ..fields['purchaseDate'] = purchaseDate
        ..fields['reminderTime'] = reminderTime;

      // Attach photo
      final photoFile = await http.MultipartFile.fromPath('photo', photo.path);
      request.files.add(photoFile);

      // Send request
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(responseData.body);
        return {'success': true, 'message': data['message'], 'plantId': data['plantId']};
      } else {
        final errorData = jsonDecode(responseData.body);
        return {'success': false, 'message': errorData['error'] ?? 'Failed to add plant.'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
