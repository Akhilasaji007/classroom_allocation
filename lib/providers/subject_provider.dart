import 'package:classroom_allocation/models/subject_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class SubjectProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Subject> _subjects = [];
  Subject? _subjectDetails;
  bool _isLoading = false;
  String? _error;

  List<Subject> get subjects => _subjects;
  Subject? get subjectDetails => _subjectDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSubjects() async {
    try {
      final Map<String, dynamic> responseMap =
          await _apiService.getList('subjects');
      final List<dynamic> subjectList = responseMap['subjects'];
      _subjects = subjectList.map((data) => Subject.fromJson(data)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Error Feteching Subjects');
    }
  }

  Future<void> fetchSubjectDetail(int subjectsId) async {
    _isLoading = true;
    _error = null;

    try {
      final response = await _apiService.getDetails('subjects', subjectsId);
      _subjectDetails = Subject.fromJson(response);
    } catch (e) {
      _subjectDetails = null;
      _error = 'Error Fetching Subject: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
