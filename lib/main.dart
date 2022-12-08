import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:library_management_app/view/add_book_view.dart';
import 'package:library_management_app/view/add_student_view.dart';
import 'package:library_management_app/view/book_search_view.dart';
import 'package:library_management_app/view/home_view.dart';
import 'package:library_management_app/view/student_portal_view.dart';

import 'app_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: AddBookView.id, page: () => AddBookView()),
        GetPage(name: BookSearchView.id, page: () => BookSearchView()),
        GetPage(
            name: StudentPortalView.id, page: () => const StudentPortalView()),
        GetPage(name: AddStudentView.id, page: () => AddStudentView()),
      ],
      initialBinding: AppBindings(),
    );
  }
}
