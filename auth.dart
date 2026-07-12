import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _tokenKey = "token";

  static String? accessToken;

  /// Save Token
  static Future<void> saveUserToken(String token) async {
    accessToken = token;

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
  }

  /// Load Token
  static Future<void> loadUserToken() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    accessToken = prefs.getString(_tokenKey);
  }

  /// Check Login
  static bool get isLoggedIn {
    return accessToken != null &&
        accessToken!.isNotEmpty;
  }

  /// Logout
  static Future<void> logout() async {
    accessToken = null;

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
  }

  /// Clear Token
  static Future<void> clearToken() async {
    await logout();
  }
}
