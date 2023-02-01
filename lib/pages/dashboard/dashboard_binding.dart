import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/pages/dashboard/dashboard_controller.dart';
import 'package:tmdb_app/pages/home/home_controller.dart';
class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}