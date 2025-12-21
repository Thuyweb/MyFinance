import 'dart:ui';

class CountryService {
  static String get countryCode {
    final locale = PlatformDispatcher.instance.locale;
    return locale.countryCode ?? 'US';
  }
}
