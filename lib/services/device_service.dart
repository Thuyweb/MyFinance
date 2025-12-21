import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static final _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return android.id ?? 'unknown_android';
    }
    if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return ios.identifierForVendor ?? 'unknown_ios';
    }
    return 'unknown_device';
  }
}
