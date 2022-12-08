import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controller/home_controller.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/view/book_search_view.dart';
import 'package:library_management_app/view/issue_or_return_view.dart';
import 'package:library_management_app/widgets/app_drawer.dart';
import 'package:library_management_app/widgets/book_container.dart';

import 'add_book_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      fetch();
    });
  }

  void fetch() async {
    await controller.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.find<HomeController>();

    SizeConfig().init(context);
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('E-Library'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(BookSearchView.id);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(
        () => controller.loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: SizeConfig.blockSizeHorizontal * 8,
                    // mainAxisSpacing: SizeConfig.blockSizeVertical * 2,
                    childAspectRatio: 3 / 4),
                itemBuilder: (_, index) =>
                    BookContainer(controller.books[index]),
                itemCount: controller.books.length,
              ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: key,
        // duration: const Duration(seconds: 1),
        distance: 60.0,
        type: ExpandableFabType.up,
        // fanAngle: 70,
        // child: const Icon(Icons.account_box),
        // foregroundColor: Colors.amber,
        // backgroundColor: Colors.green,
        // closeButtonStyle: const ExpandableFabCloseButtonStyle(
        //   child: Icon(Icons.abc),
        //   foregroundColor: Colors.deepOrangeAccent,
        //   backgroundColor: Colors.lightGreen,
        // ),
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
          // blur: 5,
        ),
        // onOpen: () {
        //   debugPrint('onOpen');
        // },
        // afterOpen: () {
        //   debugPrint('afterOpen');
        // },
        // onClose: () {
        //   debugPrint('onClose');
        // },
        // afterClose: () {
        //   debugPrint('afterClose');
        // },
        children: [
          ElevatedButton(
              onPressed: () {
                // Get.toNamed(AddBookView.id);
                Get.to(() => AddBookView());
              },
              child: const Text('Add a Book')),
          ElevatedButton(
              onPressed: () {
                Get.to(() => IssueReturnBookView(isIssue: true));
              },
              child: const Text('Issue Book')),
          ElevatedButton(
              onPressed: () {
                Get.to(() => IssueReturnBookView(isIssue: false));
              },
              child: const Text('Return Book')),
          // FloatingActionButton.small(
          //   heroTag: null,
          //   child: const Icon(Icons.edit),
          //   onPressed: () {},
          // ),
          // FloatingActionButton.small(
          //   heroTag: null,
          //   child: const Icon(Icons.search),
          //   onPressed: () {
          //     // Navigator.of(context).push(
          //     //     MaterialPageRoute(builder: ((context) => const NextPage())));
          //   },
          // ),
          // FloatingActionButton.small(
          //   heroTag: null,
          //   child: const Icon(Icons.share),
          //   onPressed: () {
          //     final state = key.currentState;
          //     if (state != null) {
          //       debugPrint('isOpen:${state.isOpen}');
          //       state.toggle();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
