import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controller/home_controller.dart';
import 'package:library_management_app/models/book.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/utils/snackbars.dart';

class BookDetailsView extends StatelessWidget {
  BookDetailsView({Key? key, required this.book}) : super(key: key);
  final Book book;
  final controller = Get.find<HomeController>();

  Future<void> delete(BuildContext context) async {
    final result = await controller.delete(book.id);
    if (result) {
      Get.back();
      showSuccessSnackbar('Book deleted', context);
      return;
    }
    showErrorSnackbar(controller.errorMessage, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () async {
                  if (!controller.loading) {
                    await delete(context);
                  }
                },
                icon: controller.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.delete)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 3,
                horizontal: SizeConfig.blockSizeHorizontal * 10)
            .copyWith(bottom: 0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Image.asset(
                  'assets/book.png',
                  width: SizeConfig.blockSizeHorizontal * 30,
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        book.name,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    ),
                    Text(
                      book.author,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.8),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        book.publisher,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.8),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Text(book.description),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
          ],
        ),
      ),
    );
  }
}
