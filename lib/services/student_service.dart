import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_management_app/constants/constants.dart';
import 'package:library_management_app/models/borrow.dart';
import 'package:library_management_app/models/student.dart';

class StudentService {
  final dio = Dio();

  Future<Map<String, dynamic>> getAllStudents() async {
    try {
      final response = await dio.get('${baseUrl}student/get');
      if (response.statusCode == 200) {
        return {
          'status': 200,
          'students': List<Student>.from(response.data['students']
              .map((student) => Student.fromJson(student))),
        };
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? "Can't fetch students",
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred. Try again.',
      };
    }
  }

  Future<Map<String, dynamic>> addStudent(
      String name, String id, String degree, String year, String branch) async {
    try {
      final response = await dio.post('${baseUrl}student/add',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: jsonEncode({
            'id': id,
            'name': name,
            'branch': branch,
            'degree': degree,
            'year': year,
          }));
      if (response.statusCode == 200) {
        return {
          'status': 200,
          'created': response.data['created'],
          'student': Student.fromJson(response.data['student'])
        };
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not add student'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred. Try again.',
      };
    }
  }

  Future<Map<String, dynamic>> getBorrowHistory(String studentId) async {
    try {
      final response = await dio.get('${baseUrl}student/history',
          queryParameters: {
            'id': studentId,
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        return {
          'status': 200,
          'history': List<Borrow>.from(response.data['history']
              .map((history) => Borrow.fromJson(history))),
        };
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not fetch history'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred. Try again.',
      };
    }
  }
}
