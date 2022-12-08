import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/view/student_portal_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text('E-library Management App')),
          ListTile(
            onTap: () {
              Get.offAllNamed('/');
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed(StudentPortalView.id);
            },
            leading: const Icon(Icons.person),
            title: const Text('Student Portal'),
          ),
        ],
      ),
    );
  }
}
