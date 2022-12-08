import 'package:get/get.dart';
import 'package:library_management_app/services/student_service.dart';

class StudentController extends GetxController {
  final allStudents = [].obs;
  final studentService = StudentService();
  final isLoading = false.obs;
  final borrowHistory = [].obs;
  String errorMessage = '';

  List get students => [...allStudents.value];

  List get history => [...borrowHistory.value];

  Future<void> fetchStudents() async {
    isLoading(true);
    final result = await studentService.getAllStudents();
    if (result['status'] == 200) {
      allStudents(result['students']);
    } else {
      allStudents([]);
    }
    isLoading(false);
  }

  Future<Map<String, dynamic>> addStudent(
      String name, String id, String degree, String year, String branch) async {
    isLoading(true);
    final result =
        await studentService.addStudent(name, id, degree, year, branch);
    if (result['status'] == 200) {
      if (result['created']) {
        List newList = students;
        newList.add(result['student']);
        allStudents(newList);
        isLoading(false);
        return {
          'result': true,
          'created': true,
        };
      } else {
        isLoading(false);
        return {
          'result': true,
          'created': false,
        };
      }
    } else {
      isLoading(false);
      return {
        'result': false,
      };
    }
  }

  Future<void> fetchHistory(String id) async {
    isLoading(true);
    final result = await studentService.getBorrowHistory(id);
    isLoading(false);
    if (result['status'] == 200) {
      borrowHistory(result['history']);
    } else {
      errorMessage = result['message'];
      borrowHistory([]);
    }
  }
}
