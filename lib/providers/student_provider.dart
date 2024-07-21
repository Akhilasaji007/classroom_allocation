import 'package:classroom_allocation/models/student_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class StudentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Student> _students = [];
  Student? _studentDetails;
  bool _isLoading = false;
  String? _error;

  List<Student> get students => _students;
  Student? get studentDetails => _studentDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStudents() async {
    try {
      final Map<String, dynamic> responseMap =
          await _apiService.getList('students');
      final List<dynamic> studentList = responseMap['students'];
      _students = studentList.map((data) => Student.fromJson(data)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Error Feteching Students');
    }
  }

  Future<void> fetchStudentDetail(int studentId) async {
    _isLoading = true;
    _error = null;

    try {
      final response = await _apiService.getDetails('students', studentId);
      _studentDetails = Student.fromJson(response);
    } catch (e) {
      _studentDetails = null;
      _error = 'Error Fetching Student: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
