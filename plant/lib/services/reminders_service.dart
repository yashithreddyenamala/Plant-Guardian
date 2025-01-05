import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemindersService {
  static const String _baseUrl = 'http://213.210.21.159:5000/api/user/reminders';

  /// Fetch reminders from the backend API
  static Future<List<Map<String, dynamic>>> fetchReminders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token', // Pass the token for authentication
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['reminders']);
      } else {
        throw Exception('Failed to fetch reminders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in RemindersService.fetchReminders: $e');
      return [];
    }
  }
}
