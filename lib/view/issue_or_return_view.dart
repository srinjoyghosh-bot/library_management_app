import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/utils/snackbars.dart';

import '../controller/home_controller.dart';
import '../size_config.dart';

class IssueReturnBookView extends StatelessWidget {
  IssueReturnBookView({Key? key, required this.isIssue}) : super(key: key);
  final bool isIssue;
  static const String id = '/issue-return';
  final controller = Get.find<HomeController>();
  final formKey = GlobalKey<FormState>();
  String bookId = '', studentId = '';

  Future<void> save(BuildContext context) async {
    final isValid = formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    formKey.currentState?.save();
    Map<String, dynamic> result;
    if (isIssue) {
      print('issue function call');
      result = await controller.issueBook(studentId, bookId);
    } else {
      print('return function call');
      result = await controller.returnBook(studentId, bookId);
    }
    if (result['status']) {
      showSuccessSnackbar(result['message'], context);
      return;
    }
    showErrorSnackbar(result['message'], context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isIssue ? 'Issue Book' : 'Return Book'),
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
                  // Text('Login',
                  //     style: TextStyle(
                  //         // color: brandColor,
                  //         fontSize: SizeConfig.blockSizeVertical * 4)),
                  // SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.black.withOpacity(0.65)),
                      labelText: 'Book ID',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a book id';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      bookId = value!.trim();
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
                      labelText: 'Student Enrollment ID',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the enrollment ID';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      studentId = value!.trim();
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (!controller.isLoading.value) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await save(context);
                            }
                          },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  isIssue ? 'Issue' : 'Return',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2),
                                )
                          // _model.state == ViewState.idle
                          //     ?
                          // Text(
                          //   'Login',
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
                  //     // Navigator.pushReplacementNamed(context, SignupScreen.id);
                  //   },
                  //   icon: const Icon(Icons.arrow_circle_right_outlined),
                  //   label: Text('Signup',
                  //       style: TextStyle(
                  //           fontSize: SizeConfig.blockSizeVertical * 2)),
                  // ),
                  // const Spacer(),
                ],
              )),
        ),
      ),
    );
  }
}
