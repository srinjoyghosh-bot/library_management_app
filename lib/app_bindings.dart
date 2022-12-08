import 'package:get/get.dart';
import 'package:library_management_app/controller/book_search_controller.dart';
import 'package:library_management_app/controller/home_controller.dart';
import 'package:library_management_app/controller/student_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<BookSearchController>(() => BookSearchController(),
        fenix: true);
    Get.lazyPut<StudentController>(() => StudentController(), fenix: true);
  }
}
