// app_session.dart
class AppSession {
  static final AppSession _instance = AppSession._internal();
  factory AppSession() => _instance;

  AppSession._internal();

  String? role;
  String? userId;
  String? email;

  void clear() {
    role = null;
    userId = null;
    email = null;
  }
}
