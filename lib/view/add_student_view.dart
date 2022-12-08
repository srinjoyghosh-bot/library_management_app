import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/enums.dart';
import 'package:library_management_app/controller/student_controller.dart';
import 'package:library_management_app/utils/snackbars.dart';

import '../size_config.dart';

class AddStudentView extends StatelessWidget {
  AddStudentView({Key? key}) : super(key: key);
  static const String id = '/add-student';
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<StudentController>();
  String name = '', studentId = '', branch = '', imageUrl = '';
  Degree? degree;
  int? year;

  Future<void> save(BuildContext context) async {
    final isValid = formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    formKey.currentState?.save();
    final result = await controller.addStudent(
        name, studentId, degree.toString(), year.toString(), branch);
    if (!result['result']) {
      showErrorSnackbar('Could not add Student', context);
    } else {
      if (result['created']) {
        showSuccessSnackbar('Student added!', context);
      } else {
        showSuccessSnackbar('Student already exists', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add a Student'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5,
                vertical: SizeConfig.blockSizeVertical * 2),
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10,
                vertical: SizeConfig.blockSizeVertical * 2),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Spacer(),
                    // Text('Signup',
                    //     style: TextStyle(
                    //         color: Colors.blueAccent,
                    //         fontSize: SizeConfig.blockSizeVertical * 4)),
                    // SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.65)),
                        labelText: 'Name',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!.trim();
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.65)),
                        labelText: 'Enrollment ID',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid ID';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        studentId = value!.trim();
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    DropdownButtonFormField(
                      // focusColor: Colors.black,
                      items: const [
                        DropdownMenuItem(
                          value: Degree.btech,
                          child: Text('BTech'),
                        ),
                        DropdownMenuItem(
                          value: Degree.imsc,
                          child: Text('Integrated Msc'),
                        ),
                        DropdownMenuItem(
                          value: Degree.mtech,
                          child: Text('MTech'),
                        ),
                        DropdownMenuItem(
                          value: Degree.phd,
                          child: Text('Phd'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value is Degree) {
                          degree = value;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Choose a degree';
                        }
                        return null;
                      },
                      hint: const Text('Select a degree'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    DropdownButtonFormField(
                      // focusColor: Colors.black,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('I'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('II'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('III'),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text('IV'),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text('V'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value is int) {
                          year = value;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Choose a year';
                        }
                        return null;
                      },
                      hint: const Text('Select a year'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    DropdownButtonFormField(
                      // focusColor: Colors.black,
                      items: const [
                        DropdownMenuItem(
                          value: 'Applied Mathematics',
                          child: Text('Applied Mathematics'),
                        ),
                        DropdownMenuItem(
                          value: 'Computer Science Engineering',
                          child: Text('CSE'),
                        ),
                        DropdownMenuItem(
                          value: 'Electronics and Communication Engineering',
                          child: Text('ECE'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value is String) {
                          branch = value;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Choose a branch';
                        }
                        return null;
                      },
                      hint: const Text('Select a branch'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (!controller.isLoading.value) {
                                await save(context);
                              }
                            },
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Add',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2),
                                  )
                            // _model.state == ViewState.idle
                            //     ? Text(
                            //   'Signup',
                            //   style: TextStyle(
                            //       fontSize: SizeConfig.blockSizeVertical * 2),
                            // )
                            //     : SizedBox(
                            //   height: SizeConfig.blockSizeVertical * 2,
                            //   child: const CircularProgressIndicator(
                            //     color: Colors.white,
                            //   ),
                            // )
                            ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     Navigator.pushReplacementNamed(context, LoginScreen.id);
                    //   },
                    //   icon: const Icon(Icons.arrow_circle_left_outlined),
                    //   label: Text('Login',
                    //       style: TextStyle(
                    //           fontSize: SizeConfig.blockSizeVertical * 2)),
                    // ),
                    // const Spacer(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
