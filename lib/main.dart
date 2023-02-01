import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/repository/view_model/auth_view_model.dart';
import 'package:tmdb_app/themes/app_theme.dart';
import 'package:tmdb_app/utils/routes/app_pages.dart';
import 'package:tmdb_app/utils/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: GetMaterialApp(
        initialRoute: AppRoutes.DASHBOARD,
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

      ),
    );
  }
}
