import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/controllers/HomeController.dart';
import 'package:rest_api/controllers/HomeController.dart';
import 'package:rest_api/screens/home.dart';

import 'configs/app_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Rest API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut<HomeController>(
      //         () => HomeController(),
      //   );
      // })
      initialBinding: AppBinding()
    );
  }
}
