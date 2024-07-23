import 'package:classroom_allocation/models/register_model.dart';
import 'package:classroom_allocation/models/student_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class RegistrationProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _registartions = [];
  Register? _registerDetails;
  String? _isDelete;

  List<dynamic> get registartions => _registartions;
  Register? get registerDetails => _registerDetails;
  String? get isDelete => _isDelete;

  Student? _studentDetails;
  Student? get studentDetails => _studentDetails;

  Future<void> fetchRegistartions() async {
    try {
      final Map<String, dynamic> responseMap =
          await _apiService.getList('registration');

      final List<dynamic> registartionList = responseMap['registrations'];

      _registartions =
          registartionList.map((data) => Register.fromJson(data)).toList();

      notifyListeners();
    } catch (e) {
      throw Exception('Failed Feteching Registartions');
    }
  }

  Future<void> fetchRegistartionDetail(int studentId, int subjectId) async {
    try {
      final response = await _apiService.getDetails('students', studentId);
      _studentDetails = Student.fromJson(response);

      notifyListeners();
    } catch (e) {
      throw Exception('Failed Feteching Registartion');
    }
  }

  Future<void> studentRegistration(int studentId, int subjectId) async {
    try {
      final response = await _apiService.registerStudent(studentId, subjectId);
      _registerDetails = Register.fromJson(response);
    } catch (e) {
      throw Exception('Failed Student Registration');
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteRegistration(int registerId) async {
    try {
      final response = await _apiService.deleteRegistration(registerId);
      if (response == 200) {
        _isDelete = 'Registration $registerId deleted';
      } else {
        _isDelete = 'Failed to Delete';
      }
    } catch (e) {
      throw Exception('Failed to Delete');
    } finally {
      notifyListeners();
    }
  }
}
