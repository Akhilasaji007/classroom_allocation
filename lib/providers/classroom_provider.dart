import 'package:classroom_allocation/models/classroom_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class ClassroomProvider with ChangeNotifier {
  List<Classroom> _classrooms = [];
  final ApiService _apiService = ApiService();

  List<Classroom> get classrooms => _classrooms;

  // Future<void> fetchClassrooms() async {
  //   _classrooms = (await _apiService.getList('classrooms'))
  //       .map((data) => Classroom.fromJson(data))
  //       .toList();
  //   notifyListeners();
  // }

  // Additional methods for classroom details, assignment, etc.
}
