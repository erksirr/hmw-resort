class ApiConstants {
  static const String baseUrl = 'http://localhost:8080';

  static const String roomSearch = '/room/search';
  static const String roomDetail = '/room/detail';
  static const String login = '/auth/login';
  static String get roomSearchUrl => '$baseUrl$roomSearch';
  static String get roomDetailUrl => '$baseUrl$roomDetail';
  static String get loginUrl => '$baseUrl$login';
}
