import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controller/home_controller.dart';
import 'package:library_management_app/utils/snackbars.dart';

import '../size_config.dart';

class AddBookView extends StatelessWidget {
  AddBookView({Key? key}) : super(key: key);
  static const String id = '/add-book';

  final formKey = GlobalKey<FormState>();
  String name = '', authors = '', description = '', publisher = '';
  String? imageUrl;
  final controller = Get.find<HomeController>();

  Future<void> save(BuildContext context) async {
    final isValid = formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    formKey.currentState?.save();
    final result = await controller.addBook(
        name, description, publisher, authors, imageUrl);
    if (result) {
      showSuccessSnackbar('Book added successfully!', context);
    } else {
      showErrorSnackbar(controller.errorMessage, context);
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
          title: const Text('Add a Book'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
            ),
            Container(
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
                            return 'Please enter a book name';
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
                          labelText: 'Author(s)',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a author name(s)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          authors = value!.trim();
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
                          labelText: 'Publisher',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a publisher name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          publisher = value!.trim();
                        },
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      TextFormField(
                        maxLines: 3,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(0.65)),
                          labelText: 'Description',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          description = value!.trim();
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
                          labelText: 'Image URL',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          // if (value == null || value.trim().isEmpty) {
                          //   return 'Please enter a description';
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          imageUrl = value?.trim();
                        },
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (!controller.loading) {
                                  await save(context);
                                }
                              },
                              child: controller.loading
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
          ],
        ),
      ),
    );
  }
}
