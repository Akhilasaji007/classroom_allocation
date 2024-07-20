import 'package:classroom_allocation/models/subject_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> _subjects = [];
  final ApiService _apiService = ApiService();

  List<Subject> get subjects => _subjects;

  // Future<void> fetchSubjects() async {
  //   _subjects = (await _apiService.getList('subjects'))
  //       .map((data) => Subject.fromJson(data))
  //       .toList();
  //   notifyListeners();
  // }

  // Additional methods for subject details, assignment, etc.
}
