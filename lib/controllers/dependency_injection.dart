import 'package:edupot/controllers/connection_controller.dart';
import 'package:get/instance_manager.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkConnectivity>(NetworkConnectivity(), permanent: true);
  }
}
