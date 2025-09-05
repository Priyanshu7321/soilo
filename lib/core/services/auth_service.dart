import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  // Check if user is logged in
  bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;

  // Get stored user ID
  String? get userId => _prefs.getString(_userIdKey);

  // Save login state
  Future<void> saveLoginState(String userId) async {
    await Future.wait([
      _prefs.setBool(_isLoggedInKey, true),
      _prefs.setString(_userIdKey, userId),
    ]);
  }

  // Clear login state
  Future<void> clearLoginState() async {
    await Future.wait([
      _prefs.remove(_isLoggedInKey),
      _prefs.remove(_userIdKey),
    ]);
  }
}
