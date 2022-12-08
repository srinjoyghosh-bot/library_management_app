import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controller/student_controller.dart';
import 'package:library_management_app/models/student.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/widgets/borrow_tile.dart';

class StudentDetailsView extends StatefulWidget {
  const StudentDetailsView({Key? key, required this.student}) : super(key: key);
  final Student student;

  @override
  _StudentDetailsViewState createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  late StudentController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      fetch();
    });
  }

  void fetch() async {
    await controller.fetchHistory(widget.student.enrollmentId);
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.find<StudentController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/graduate.png',
                    height: SizeConfig.blockSizeVertical * 10,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    widget.student.name,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    widget.student.enrollmentId,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    '${widget.student.year} year, ${widget.student.branch}',
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
            child: Text(
              'Borrow History',
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  color: Colors.blueAccent),
            ),
          ),
          Obx(() => Expanded(
              child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.grey),
                    )
                  : controller.history.isEmpty
                      ? Center(
                          child: Text(
                            'No books borrowed yet',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (_, index) =>
                              BorrowTile(controller.history[index]),
                          itemCount: controller.history.length,
                        )))
        ],
      ),
    );
  }
}
