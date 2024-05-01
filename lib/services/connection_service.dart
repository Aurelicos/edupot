import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:edupot/components/common/no_internet_modal.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:get/get.dart';

class NetworkConnectivity extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      Get.bottomSheet(
        const NoInternetModal(),
        isDismissible: false,
        enableDrag: false,
        backgroundColor: EduPotColorTheme.primaryDark,
      );
    } else {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    }
  }
}
