import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/size_config.dart';
import 'package:library_management_app/view/student_portal_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Center(
                  child: Text(
            'E-library Management App',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue, fontSize: SizeConfig.blockSizeVertical * 3),
          ))),
          ListTile(
            onTap: () {
              Get.offAllNamed('/');
            },
            leading: const Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed(StudentPortalView.id);
            },
            leading: const Icon(
              Icons.person,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Student Portal',
              style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
            ),
          ),
        ],
      ),
    );
  }
}
