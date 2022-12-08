import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:library_management_app/constants/constants.dart';
import 'package:library_management_app/models/book.dart';

class BookService {
  var dio = Dio();

  Future<dynamic> getAllBooks() async {
    try {
      final response = await dio.get('${baseUrl}book/',
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        return List<Book>.from(
            response.data['books'].map((book) => Book.fromJson(book)));
      } else {
        return 'Could not fetch books';
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return 'Some error ocuured. Please try again!';
    }
  }

  Future<Map<String, dynamic>> findBookById(String id) async {
    try {
      final response = await dio.get('${baseUrl}book/find',
          options: Options(headers: {'Content-Type': 'application/json'}),
          queryParameters: {
            'id': id,
          });
      if (response.statusCode == 200) {
        return {'status': 200, 'book': Book.fromJson(response.data['book'])};
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not find book'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again.'};
    }
  }

  Future<Map<String, dynamic>> findBookByName(String name) async {
    try {
      final response = await dio.get('${baseUrl}book/find-by-name',
          options: Options(headers: {'Content-Type': 'application/json'}),
          queryParameters: {
            'name': name,
          });
      if (response.statusCode == 200) {
        return {
          'status': 200,
          'books': List<Book>.from(
              response.data['books'].map((book) => Book.fromJson(book))),
        };
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not find book'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again.'};
    }
  }

  Future<Map<String, dynamic>> addBook({
    required String name,
    required String description,
    required String publisher,
    required String author,
    String? imageUrl,
  }) async {
    try {
      final response = await dio.post('${baseUrl}book/add',
          data: jsonEncode({
            'name': name,
            'description': description,
            'publisher': publisher,
            'author': author,
            'imageUrl': imageUrl
          }),
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        return {'status': 200, 'book': Book.fromJson(response.data['book'])};
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not add book!'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred. Try again.',
      };
    }
  }

  Future<Map<String, dynamic>> issueBook(
      String studentId, String bookId) async {
    print('studentId: $studentId');
    print('bookId: $bookId');
    try {
      final response = await dio.post('${baseUrl}book/issue',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: jsonEncode({
            'student_id': studentId,
            'book_id': bookId,
          }));
      print(response.data);
      if (response.statusCode == 200) {
        return {'status': 200, 'issue_details': response.data['issue_details']};
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not issue book'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again.'};
    }
  }

  Future<Map<String, dynamic>> returnBook(
      String studentId, String bookId) async {
    try {
      final response = await dio.put('${baseUrl}book/return',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: jsonEncode({
            'student_id': studentId,
            'book_id': bookId,
          }));
      if (response.statusCode == 200) {
        return {'status': 200, 'result': response.data['result']};
      }
      return {
        'status': response.statusCode,
        'message': response.data['message'] ?? 'Could not issue book'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again.'};
    }
  }
}
