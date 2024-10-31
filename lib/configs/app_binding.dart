import 'package:get/get.dart';
import 'package:rest_api/controllers/HomeController.dart';
import 'package:rest_api/controllers/TodoController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);
  }
}
