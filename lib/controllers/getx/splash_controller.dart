import 'package:get/get.dart';
import 'package:notedo_app/views/homepage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashController();
  }

  void splashController() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(HomeScreen());
    });
  }
}
