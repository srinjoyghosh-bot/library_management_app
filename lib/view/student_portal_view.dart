import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controller/student_controller.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/view/add_student_view.dart';
import 'package:library_management_app/widgets/app_drawer.dart';
import 'package:library_management_app/widgets/student_tile.dart';

class StudentPortalView extends StatefulWidget {
  const StudentPortalView({Key? key}) : super(key: key);
  static const String id = '/student-portal';

  @override
  _StudentPortalViewState createState() => _StudentPortalViewState();
}

class _StudentPortalViewState extends State<StudentPortalView> {
  late StudentController controller;
  late List students;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      fetch();
    });
    super.initState();
  }

  void fetch() async {
    await controller.fetchStudents();
    students = controller.students;
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.find<StudentController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Student Portal'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 1.5),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              TextField(
                style: const TextStyle(color: Colors.blue),
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  debugPrint(value);
                },
                onChanged: (value) {
                  // print(value.replaceAll(' ', '').isEmpty);
                  if (value.replaceAll(' ', '').isEmpty) {
                    setState(() {
                      students = controller.students;
                    });
                  } else {
                    setState(() {
                      students = controller.students
                          .where(
                              (student) => student.enrollmentId.contains(value))
                          .toList();
                    });
                  }
                },
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: const InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Search by enrollment',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    )
                  : students.isEmpty
                      ? const Center(
                          child: Text('No students'),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (_, index) =>
                                StudentTile(student: students[index]),
                            itemCount: students.length,
                          ),
                        ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a student',
          onPressed: () {
            Get.toNamed(AddStudentView.id);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
