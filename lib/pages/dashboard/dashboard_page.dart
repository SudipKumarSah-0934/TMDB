import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/pages/chats/chats_page.dart';
import 'package:tmdb_app/pages/home/home_page.dart';
import 'package:tmdb_app/pages/menu/menus_page.dart';
import 'package:tmdb_app/pages/profile/profile_page.dart';
import '../menu/menus.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Color(0xff05103A),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              HomePage(),
              MenusPage(),
              ChatsPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff05103A),
          unselectedItemColor: Colors.white70,
          selectedItemColor: Colors.white,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavigationBarItem(
              CupertinoIcons.home,
              'Home',
            ),
            _bottomNavigationBarItem(
              CupertinoIcons.news,
              'News',
            ),
            _bottomNavigationBarItem(
              CupertinoIcons.bell,
              'Notification',
            ),
            _bottomNavigationBarItem(
              CupertinoIcons.profile_circled,
              'Profile',
            ),
          ],
        ),
      );
    });
  }

  _bottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
