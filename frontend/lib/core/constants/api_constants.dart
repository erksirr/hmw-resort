class ApiConstants {
  static const String baseUrl = 'http://localhost:8080';

  static const String roomSearch = '/room/search';
  static const String roomDetail = '/room/detail';
  static const String login = '/auth/login';
  static const String googleLogin = '/auth/google';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';
  static String get roomSearchUrl => '$baseUrl$roomSearch';
  static String get roomDetailUrl => '$baseUrl$roomDetail';
  static String get loginUrl => '$baseUrl$login';
  static String get googleLoginUrl => '$baseUrl$googleLogin';
  static String get logoutUrl => '$baseUrl$logout';
  static String get registerUrl => '$baseUrl$register';
}
