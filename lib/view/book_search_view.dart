import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/enums.dart';
import 'package:library_management_app/controller/book_search_controller.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/widgets/book_container.dart';

class BookSearchView extends StatelessWidget {
  BookSearchView({Key? key}) : super(key: key);
  static const String id = '/book-search';

  late BookSearchController controller;

  Widget searchParamDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal),
          side: const BorderSide(color: Colors.blue, width: 2)),
      insetPadding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 25),
      child: Container(
        // height: SizeConfig.blockSizeVertical * 20,
        width: SizeConfig.blockSizeHorizontal * 5,
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.blue, width: 2),
        //     borderRadius:
        //         BorderRadius.circular(SizeConfig.blockSizeHorizontal)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical),
            Text(
              'Search by:',
              style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.5),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
              ),
            ),
            GestureDetector(
                child: Container(
                  width: double.infinity,
                  color: Colors.blueGrey,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2),
                  child: const Text(
                    'NAME',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  controller.changeParam(SearchParam.name);
                  Get.back();
                }),
            // SizedBox(height: SizeConfig.blockSizeVertical),
            Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
              ),
            ),
            GestureDetector(
                child: Container(
                  width: double.infinity,
                  color: Colors.blueGrey,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2),
                  child: const Text(
                    'BOOK ID',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  controller.changeParam(SearchParam.id);
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.find<BookSearchController>();
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) async {
              await controller.searchBook(value);
            },
            autofocus: true,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => searchParamDialog());
              },
              child: Obx(
                () => Container(
                  width: SizeConfig.blockSizeHorizontal * 7,
                  height: SizeConfig.blockSizeVertical * 2,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical,
                    horizontal: SizeConfig.blockSizeHorizontal,
                  ),
                  color: Colors.white,
                  child: Text(
                    controller.searchParam.value == SearchParam.id
                        ? 'ID'
                        : 'NM',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            )
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context, builder: (context) => searchParamDialog());
            //   },
            //   icon: const Icon(Icons.done),
            // )
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              : controller.searchResult.value == null
                  ? Container()
                  : controller.result!.isEmpty
                      ? const Center(
                          child: Text('No books found'),
                        )
                      : GridView.builder(
                          itemBuilder: (_, index) =>
                              BookContainer(controller.result![index]),
                          itemCount: controller.result!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      SizeConfig.blockSizeHorizontal * 8,
                                  mainAxisSpacing:
                                      SizeConfig.blockSizeVertical * 2,
                                  childAspectRatio: 3 / 4),
                        ),
        ));
  }
}
