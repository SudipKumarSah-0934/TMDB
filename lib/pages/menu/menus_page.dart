import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/pages/menu/menus_controller.dart';

class MenusPage extends GetView<MenusController>{
  const MenusPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Menus Page",style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

}