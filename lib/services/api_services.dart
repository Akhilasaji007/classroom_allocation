import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '55EEE';
  final String baseUrl = 'https://nibrahim.pythonanywhere.com/';

  Future<Map<String, dynamic>> getList(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$endpoint/?api_key=$apiKey'), headers: {
        'Authorization': 'Bearer $apiKey',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Invalid API Key or insufficient permissions.');
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getDetails(String endpoint, int studentId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl$endpoint/$studentId?api_key=$apiKey'),
          headers: {
            'Authorization': 'Bearer $apiKey',
          });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return data;
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Invalid API Key or insufficient permissions.');
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<int> updateSubject(int classroomId, int subjectId) async {
    try {
      String endpoint = 'classrooms';
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint/$classroomId?api_key=$apiKey'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'subject=$subjectId',
      );
      return response.statusCode;
    } catch (e) {
      throw Exception('Failed to Update Subject');
    }
  }
}
