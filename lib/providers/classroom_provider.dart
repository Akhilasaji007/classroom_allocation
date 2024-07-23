import 'package:classroom_allocation/models/classroom_model.dart';
import 'package:classroom_allocation/services/api_services.dart';
import 'package:flutter/material.dart';

class ClassRoomProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<ClassRoom> _classrooms = [];
  ClassRoom? _classroomDetails;
  String _isSuccess = '';

  List<ClassRoom> get classrooms => _classrooms;
  ClassRoom? get classroomDetails => _classroomDetails;
  String get isSuccess => _isSuccess;

  Future<void> fetchClassRooms() async {
    try {
      final Map<String, dynamic> responseMap =
          await _apiService.getList('classrooms');
      final List<dynamic> classroomList = responseMap['classrooms'];
      _classrooms =
          classroomList.map((data) => ClassRoom.fromJson(data)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Error Feteching ClassRooms');
    }
  }

  Future<void> fetchClassRoomDetail(int classroomId) async {
    try {
      final response = await _apiService.getDetails('classrooms', classroomId);
      _classroomDetails = ClassRoom.fromJson(response);
    } catch (e) {
      _classroomDetails = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateClassroomSubject(int classroomId, int subjectId) async {
    try {
      final response = await _apiService.updateSubject(classroomId, subjectId);
      if (response == 200) {
        _isSuccess = 'Subject Updated';
      } else {
        _isSuccess = 'Error Updating Classroom Subject';
      }
    } catch (e) {
      throw Exception('Error Updating Classroom Subject');
    } finally {
      notifyListeners();
    }
  }
}
