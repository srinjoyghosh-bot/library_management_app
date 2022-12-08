import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/models/student.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/view/student_details_view.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({Key? key, required this.student}) : super(key: key);
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: ListTile(
        onTap: () {
          Get.to(() => StudentDetailsView(student: student));
        },
        title: Text(student.name),
        leading: Image.asset('assets/graduate.png'),
        subtitle: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
                '${student.enrollmentId},${student.year},${student.branch}')),
      ),
    );
  }
}
