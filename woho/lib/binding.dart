import 'package:get/get.dart';
import 'package:woho/viewmodel/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
