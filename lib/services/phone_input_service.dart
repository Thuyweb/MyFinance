import '../utils/phone_util.dart';
import 'country_service.dart';

class PhoneInputService {
  static String normalize(String input) {
    String phone = input.trim();

    // remove spaces, -, ()
    phone = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // already E.164
    if (phone.startsWith('+')) {
      return phone;
    }

    final country = CountryService.countryCode;
    final phoneCode = countryPhoneCodes[country] ?? '1';

    // starts with 0 (local)
    if (phone.startsWith('0')) {
      return '+$phoneCode${phone.substring(1)}';
    }

    // starts with country code but missing +
    if (phone.startsWith(phoneCode)) {
      return '+$phone';
    }

    return '+$phoneCode$phone';
  }

  static bool isValid(String phone) {
    return RegExp(r'^\+\d{9,15}$').hasMatch(phone);
  }
}
