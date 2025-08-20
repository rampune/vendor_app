import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission() async {
  // Check current status
  var status = await Permission.camera.status;

  if (status.isGranted) {
    // Already granted
    return true;
  } else {
    // Request permission
    status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // If permanently denied → open app settings
      await openAppSettings();
      // After user returns, check again
      var newStatus = await Permission.camera.status;
      return newStatus.isGranted;
    } else {
      // Denied (but not permanent)
      return false;
    }
  }
}